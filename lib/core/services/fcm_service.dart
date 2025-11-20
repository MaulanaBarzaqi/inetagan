import 'dart:convert';
import 'package:d_method/d_method.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/routes/app_router.dart';
import 'package:uuid/uuid.dart';

import '../../features/notifications/data/datasources/notification_local_datasource.dart';
import '../../features/notifications/data/models/notification_model.dart';
import '../../features/notifications/presentation/cubit/notifications_cubit.dart';
import '../../injection.dart';

// ====================================================================
// KONSTANTA GLOBAL
// ====================================================================
const String _kChannelId = 'high_importance_channel';
const String _kChannelName = 'Inetagan Notifications';
const String _kNotificationSound = 'notification';
const String _kChannelDescription =
    'This channel is used for important notifications from Inetagan';
final _uuid = const Uuid();

// ====================================================================
// CONFIGURASI & DETAIL NOTIFIKASI
// ====================================================================
// configuration settings for flutter local notifications
const AndroidInitializationSettings _androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
const InitializationSettings _initializationSettings = InitializationSettings(
  android: _androidInitializationSettings,
  iOS: null,
);
// Details untuk menampilkan notifikasi
const AndroidNotificationDetails _androidNotificationDetails =
    AndroidNotificationDetails(
      _kChannelId,
      _kChannelName,
      channelDescription: _kChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(_kNotificationSound),
      enableVibration: true,
      colorized: true,
      color: AppColors.primary,
    );

const NotificationDetails _notificationDetails = NotificationDetails(
  android: _androidNotificationDetails,
  iOS: null,
);
// Channel untuk Android (harus dibuat sebelum notifikasi ditampilkan)
const AndroidNotificationChannel _androidNotificationChannel =
    AndroidNotificationChannel(
      _kChannelId,
      _kChannelName,
      description: _kChannelDescription,
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(_kNotificationSound),
      enableVibration: true,
    );

// ====================================================================
// FUNGSI GLOBAL & HANDLER NAVIGASI
// ====================================================================
/// Menangani navigasi berdasarkan data payload
void _navigateBasedOnData(Map<String, dynamic> data) {
  final messageType = data['type'];
  DMethod.logTitle('NAVIGATION TRIGGERED', 'Type: $messageType | Data: $data');
  router.go(const NotificationRoute().location, extra: data);
  DMethod.log('Navigasi ke Halaman Pemberitahuan, membawa data payload.');
}

/// Handler Global untuk merespon klik notifikasi lokal (FLN).
void onDidReceiveNotificationResponse(NotificationResponse response) {
  final payLoad = response.payload;
  DMethod.logTitle('FLN RESPONSE TAPPED', 'payload : $payLoad');

  if (payLoad != null && payLoad.isNotEmpty) {
    try {
      final data = jsonDecode(payLoad) as Map<String, dynamic>;
      _navigateBasedOnData(data);
    } catch (e) {
      DMethod.logTitle('FLN PAYLOAD ERROR', 'Failed to parse payload: $e');
    }
  }
}

/// Fungsi pembantu untuk menyimpan notifikasi lokal
Future<void> _saveNotification(RemoteMessage message, Uuid localUuid) async {
  final notification = message.notification;
  final data = message.data;

  if (notification != null || data.isNotEmpty) {
    final newNotification = NotificationModel(
      id: localUuid.v4(),
      title: notification?.title,
      body: notification?.body,
      dataPayload: data,
      receivedAt: DateTime.now(),
      isRead: false,
    );
    try {
      // Coba simpan via Cubit (jika tersedia di locator)
      locator<NotificationsCubit>().saveAndReload(newNotification);
      DMethod.log('Notification saved and Cubit reloaded');
    } catch (e) {
      // Fallback ke Datasource jika Cubit belum tersedia
      locator<NotificationLocalDatasource>().saveNotification(newNotification);
      DMethod.logTitle(
        'NOTIF SAVE FALLBACK',
        'Cubit not available, saved via Datasource. $e',
      );
    }
  }
}

// ====================================================================
// HANDLER BACKGROUND
// ====================================================================
// Background message handler untuk Android
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await initLocator();

  DMethod.logTitle(
    'BACKGROUND MESSAGE HANDLED',
    'Message ID: ${message.messageId}\nData: ${message.data}',
  );
  // Setup local notifications untuk background
  final notifications = FlutterLocalNotificationsPlugin();
  // Setup Channel dan Inisialisasi FLN (harus diulang di isolate background)
  await notifications
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(_androidNotificationChannel);

  await notifications.initialize(
    _initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveNotificationResponse,
  );
  await _saveNotification(message, const Uuid());
  // tampilan notifikasi di background
  final notification = message.notification;
  final data = message.data;

  if (notification != null || data.isNotEmpty) {
    final payloadString = data.isNotEmpty ? jsonEncode(data) : null;
    final notificationId = DateTime.now().millisecondsSinceEpoch.remainder(
      100000,
    );
    await notifications.show(
      notificationId,
      notification?.title ?? 'Inetagan',
      notification?.body ?? 'You have a new notification',
      _notificationDetails,
      payload: payloadString,
    );
    DMethod.logTitle(
      'BACKGROUND NOTIFICATION SHOWN',
      'ID: $notificationId\nTitle: ${notification?.title}',
    );
  }
}

// ====================================================================
// FcmService CLASS
// ====================================================================
class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<String?> getFcmToken() async {
    try {
      await _firebaseMessaging.setAutoInitEnabled(true);
      String? token = await _firebaseMessaging.getToken();
      DMethod.logTitle('FCM token:', '$token');
      return token;
    } catch (e) {
      DMethod.logTitle('error getting FCM token:', '$e');
      return null;
    }
  }

  /// Menyiapkan Channel, Izin, dan Listener
  Future<void> setupListeners() async {
    try {
      DMethod.log('setting up fcm listeners...');
      // 1. setup channel dan inisialisasi FLN
      await _setupAndroidNotifications();
      // 2. permintaan izin
      await _requestNotificationPermission();
      // 3. setup listener
      _setupMessageListeners();
      DMethod.logTitle(
        'FCM SETUP COMPLETED',
        'All listeners configured successfully',
      );
    } catch (e) {
      DMethod.logTitle('FCM SETUP ERROR', 'Error: $e');
    }
  }

  /// Meminta Izin Notifikasi (terutama untuk Android 13+)
  Future<void> _requestNotificationPermission() async {
    try {
      // Permintaan Izin via Firebase Messaging (untuk izin umum)
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      DMethod.logTitle(
        'FCM PERMISSION',
        'Status: ${settings.authorizationStatus}',
      );
      // Permintaan Izin Notifikasi (POST_NOTIFICATIONS) via FLN (Android 13+)
      final androidImplementation = _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidImplementation != null) {
        final granted = await androidImplementation
            .requestNotificationsPermission();
        DMethod.logTitle(
          'FLN PERMISSION (Android 13+)',
          'Status: ${granted == true ? 'Granted' : 'Denied'}',
        );
      }
    } catch (e) {
      DMethod.logTitle('PERMISSION REQUEST ERROR', 'Error: $e');
    }
  }

  /// Membuat Channel Notifikasi dan Menginisialisasi FLN
  Future<void> _setupAndroidNotifications() async {
    try {
      // create notifications channel untuk android
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_androidNotificationChannel);

      await _localNotifications.initialize(
        _initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse,
      );
      DMethod.log('Android notification channel created and FLN initialized');
    } catch (e) {
      DMethod.logTitle('NOTIFICATION SETUP ERROR', 'Error: $e');
    }
  }

  /// Menyiapkan listener untuk pesan
  void _setupMessageListeners() {
    // Background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      DMethod.logTitle(
        'FCM FOREGROUND MESSAGE',
        'Message ID: ${message.messageId}\nData: ${message.data}',
      );
      _showAndroidNotification(message);
    });
    // Ketika app terminated dan dibuka via notification
    _firebaseMessaging.getInitialMessage().then((
      RemoteMessage? initialMessage,
    ) {
      if (initialMessage != null) {
        _handleMessage(initialMessage);
      }
    });
    // Ketika app in background dan dibuka via notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /// Menampilkan notifikasi lokal saat aplikasi di Foreground
  Future<void> _showAndroidNotification(RemoteMessage message) async {
    try {
      await _saveNotification(message, _uuid);

      final notification = message.notification;
      final data = message.data;

      // HANYA tampilkan jika ada payload notification, atau jika ada data kustom
      if (notification != null || data.isNotEmpty) {
        final notificationId = DateTime.now().millisecondsSinceEpoch.remainder(
          100000,
        );
        final String? payloadString = data.isNotEmpty ? jsonEncode(data) : null;

        await _localNotifications.show(
          notificationId,
          notification?.title ?? 'Inetagan',
          notification?.body ?? 'You have a new notification',
          _notificationDetails,
          payload: payloadString,
        );
        DMethod.logTitle(
          'NOTIFICATION SHOWN (Foreground)',
          'ID: $notificationId\nTitle: ${notification?.title}\nBody: ${notification?.body}',
        );
      }
    } catch (e) {
      DMethod.logTitle('NOTIFICATION SHOW ERROR', 'Error: $e');
    }
  }

  /// Menangani klik pesan (ketika app dibuka via notifikasi)
  void _handleMessage(RemoteMessage message) {
    DMethod.logTitle(
      'MESSAGE HANDLED (Opened App)',
      'Message ID: ${message.messageId}\nFull Data: ${message.data}',
    );
    final data = message.data;

    // Simpan notifikasi ke database/local storage
    _saveNotification(message, _uuid);

    // Handle navigation berdasarkan data message
    if (data.isNotEmpty) {
      DMethod.logTitle('MESSAGE DATA', 'Data: $data');
      _navigateBasedOnData(data);
    }
  }
}
