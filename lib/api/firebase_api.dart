import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirebaseApi {
  // Create an instance of Firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialize notifications
  Future<void> initNotifications(String userId) async {
    // Request permission from the user (will prompt the user)
    await _firebaseMessaging.requestPermission();

    // Fetch the FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();
    // Print the token (normally we would send this to your server)
    print('FCM Token: $fcmToken');

    if (fcmToken != null) {
      await sendFcmTokenToServer(fcmToken,userId);
    }

    // Initialize further settings for push notifications
    await initPushNotifications();
  }

  // Function to handle received messages
  void handleMessage(RemoteMessage? message) {
    // If the message is null, do nothing
    if (message == null) return;
    // Navigate to a new screen when a message is received and the user taps the notification
    // navigatorKey.currentState?.pushNamed(
    //   '/notification_screen',
    //   arguments: message,
    // );
  }

  // Function to initialize foreground and background settings
  Future<void> initPushNotifications() async {
    // Handle notification if the app was terminated and then reopened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // Attach event listeners for when a notification opens the application
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  // Function to send FCM token to the server
  Future<void> sendFcmTokenToServer(String fcmToken, String userId) async {
    final url = Uri.parse('https://192.168.56.1/api/notifications/fcm-token');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'fcmToken': fcmToken,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      print('FCM token sent to server successfully');
    } else {
      print('Failed to send FCM token to server: ${response.statusCode}');
    }
  }
}
