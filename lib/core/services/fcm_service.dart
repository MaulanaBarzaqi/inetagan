import 'package:d_method/d_method.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inetagan/core/config/app_colors.dart';

class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const String _chanelId = 'high_importance_channel';
  static const String _channelName = 'Inetagan Notifications';
  static const String _channelDescription =
      'This channel is used for important notifications from Inetagan';

  Future<String?> getFcmToken() async {
    try {
      await _firebaseMessaging.setAutoInitEnabled(true);

      // await _firebaseMessaging.requestPermission(
      //   alert: true,
      //   badge: true,
      //   sound: true,
      // );
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
      await _setupAndroidNotifications();
      // reques permission untk android 13+
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
      // Untuk Android 13+ perlu request permission
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      DMethod.logTitle(
        'NOTIFICATION PERMISSION',
        'Status: ${settings.authorizationStatus}',
      );
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
      await _localNotifications.initialize(settings);
      DMethod.log('Android notification channel created');
    } catch (e) {
      DMethod.logTitle('NOTIFICATION SETUP ERROR', 'Error: $e');
    }
  }

  Future<void> _showAndroidNotification(RemoteMessage message) async {
    try {
      final notification = message.notification;
      final data = message.data;

      if (notification != null) {
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
        await _localNotifications.show(
          notificationId,
          notification.title ?? 'Inetagan',
          notification.body ?? 'You have a new notification',
          details,
          payload: data.isNotEmpty ? data.toString() : null,
        );
        DMethod.logTitle(
          'NOTIFICATION SHOWN',
          'ID: $notificationId\nTitle: ${notification.title}\nBody: ${notification.body}',
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
    // Implement navigation logic berdasarkan data
    // Contoh:
    // - data['screen'] = 'chat', 'order', 'profile', dll.
    // - data['id'] = ID spesifik untuk navigasi
    DMethod.logTitle('NAVIGATION TRIGGERED', 'Data: $data');
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
  // Initialize untuk background
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: null,
  );
  await notifications.initialize(settings);

  // Show notification di background
  final notification = message.notification;
  if (notification != null) {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'Inetagan Notifications',
          channelDescription:
              'This channel is used for important notifications from Inetagan',
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

    final notificationId = DateTime.now().millisecondsSinceEpoch.remainder(
      100000,
    );

    await notifications.show(
      notificationId,
      notification.title ?? 'Inetagan',
      notification.body ?? 'You have a new notification',
      details,
    );

    DMethod.logTitle(
      'BACKGROUND NOTIFICATION SHOWN',
      'ID: $notificationId\nTitle: ${notification.title}',
    );
  }
}
