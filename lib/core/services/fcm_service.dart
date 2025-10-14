import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/routes/app_router.dart';

// constanta channel
const String _chanelId = 'high_importance_channel';
const String _channelName = 'Inetagan Notifications';
const String _channelDescription =
    'This channel is used for important notifications from Inetagan';

// **Fungsi Global untuk Menangani Klik Notifikasi Lokal (FLN)**
// Ini akan dipanggil ketika notifikasi diklik, baik saat app di foreground atau background.
void onDidReceiveNotificationResponse(NotificationResponse response) {
  final payLoad = response.payload;
  DMethod.logTitle('FLN RESPONSE TAPPED', 'payload : $payLoad');

  if (payLoad != null && payLoad.isNotEmpty) {
    try {
      final data = jsonDecode(payLoad) as Map<String, dynamic>;
      final messageType = data['type'];
      if (messageType == 'installation_status_update') {
        router.go('/subscribe/get');
        DMethod.log('Navigasi dari FLN Payload ke Pemasangan Saya');
      }
    } catch (e) {
      DMethod.logTitle('FLN PAYLOAD ERROR', 'Failed to parse payload: $e');
    }
  }
}

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

  Future<void> setupListeners() async {
    try {
      DMethod.log('Setting up FCM listeners...');
      // setup channel n initialize plugin
      await _setupAndroidNotifications();
      // request permission to android 13+
      await _requestNotificationPermission();
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
      RemoteMessage? initialMessage = await _firebaseMessaging
          .getInitialMessage();
      if (initialMessage != null) {
        _handleMessage(initialMessage);
      }
      // Ketika app in background dan dibuka via notification
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
      DMethod.logTitle(
        'FCM SETUP COMPLETED',
        'All listeners configured successfully',
      );
    } catch (e) {
      DMethod.logTitle('FCM SETUP ERROR', 'Error: $e');
    }
  }

  Future<void> _requestNotificationPermission() async {
    try {
      // Permintaan Izin via Firebase Messaging (untuk izin umum)
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      DMethod.logTitle(
        'NOTIFICATION PERMISSION',
        'Status: ${settings.authorizationStatus}',
      );
      // Permintaan Izin Notifikasi (POST_NOTIFICATIONS) via FLN
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _localNotifications
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

  Future<void> _setupAndroidNotifications() async {
    try {
      // buat notification channel
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        _chanelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notification'),
        enableVibration: true,
      );
      // create notifications channel untuk android
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      // Initialize settings untuk Android saja
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: null, // Non-aktifkan iOS
      );
      await _localNotifications.initialize(
        settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse,
      );
      DMethod.log('Android notification channel created and FLN initialized');
    } catch (e) {
      DMethod.logTitle('NOTIFICATION SETUP ERROR', 'Error: $e');
    }
  }

  Future<void> _showAndroidNotification(RemoteMessage message) async {
    try {
      final notification = message.notification;
      final data = message.data;
      // HANYA tampilkan jika ada payload notification, atau jika ada data kustom
      if (notification != null || data.isNotEmpty) {
        const AndroidNotificationDetails androidDetails =
            AndroidNotificationDetails(
              _chanelId,
              _channelName,
              channelDescription: _channelDescription,
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              sound: RawResourceAndroidNotificationSound('notification'),
              enableVibration: true,
              colorized: true,
              color: AppColors.primary,
            );
        const NotificationDetails details = NotificationDetails(
          android: androidDetails,
          iOS: null, // Non-aktifkan iOS
        );

        // Generate unique ID berdasarkan timestamp
        final notificationId = DateTime.now().millisecondsSinceEpoch.remainder(
          100000,
        );

        final String? payloadString = data.isNotEmpty ? jsonEncode(data) : null;

        await _localNotifications.show(
          notificationId,
          notification?.title ?? 'Inetagan',
          notification?.body ?? 'You have a new notification',
          details,
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

  void _handleMessage(RemoteMessage message) {
    DMethod.logTitle(
      'MESSAGE HANDLED',
      'Message ID: ${message.messageId}\nFull Data: ${message.data}',
    );
    final data = message.data;
    final notification = message.notification;
    // Handle navigation berdasarkan data message
    if (data.isNotEmpty) {
      DMethod.logTitle('MESSAGE DATA', 'Data: $data');
      _navigateBasedOnData(data);
    } else if (notification != null) {
      DMethod.logTitle(
        'NOTIFICATION DATA',
        'Title: ${notification.title}\nBody: ${notification.body}',
      );
      // Handle general notification tap
    }
  }

  void _navigateBasedOnData(Map<String, dynamic> data) {
    final messageType = data['type'];
    DMethod.logTitle(
      'NAVIGATION TRIGGERED',
      'Type: $messageType | Data: $data',
    );
    if (messageType == 'installation_status_update') {
      DMethod.log('Navigasi ke Halaman Pemasangan Saya (Status Update)');
      router.go('/subscribe/get');
    } else {
      DMethod.log('Tipe pesan umum atau tidak dikenal.');
    }
  }
}

// Background message handler untuk Android
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  DMethod.logTitle(
    'BACKGROUND MESSAGE HANDLED',
    'Message ID: ${message.messageId}\nData: ${message.data}',
  );
  // Setup local notifications untuk background
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  // create ulang channel di background
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    _chanelId,
    _channelName,
    description: _channelDescription,
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification'),
    enableLights: true,
  );
  await notifications
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  // Initialize untuk background
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: null,
  );
  await notifications.initialize(
    settings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveNotificationResponse,
  );

  // Show notification di background
  final notification = message.notification;
  final data = message.data;

  if (notification != null || data.isNotEmpty) {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          _chanelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification'),
          enableVibration: true,
          colorized: true,
          color: AppColors.primary,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: null,
    );
    final String? payLoadString = data.isNotEmpty ? jsonEncode(data) : null;

    final notificationId = DateTime.now().millisecondsSinceEpoch.remainder(
      100000,
    );

    await notifications.show(
      notificationId,
      notification?.title ?? 'Inetagan',
      notification?.body ?? 'You have a new notification',
      details,
      payload: payLoadString,
    );

    DMethod.logTitle(
      'BACKGROUND NOTIFICATION SHOWN',
      'ID: $notificationId\nTitle: ${notification?.title}',
    );
  }
}
