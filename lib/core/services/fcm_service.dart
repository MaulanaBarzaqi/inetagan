import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getFcmToken() async {
    try {
      await _firebaseMessaging.setAutoInitEnabled(true);

      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      return await _firebaseMessaging.getToken();
    } catch (e) {
      print('error getting FCM token: $e');
      return null;
    }
  }

  Future<void> setupListeners() async {
    // background message
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    // foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message in foreground: ${message.messageId}');
      // Handle notification di sini
    });
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    // When app is in background and opened
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print('Message opened: ${message.messageId}');
    // Handle navigation berdasarkan data message
  }
}

// background handler
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling background message: ${message.messageId}");
}
