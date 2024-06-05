import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:flutter_application_1/models/notifs.dart';
import 'package:flutter_application_1/components/notification_card.dart'; // Updated import for the notification card
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<AppNotification> _notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    String url;
    final _userRole = context.read<AuthProvider>().role;
    final _id = context.read<AuthProvider>().id;

    print("this is the role in the notification page  $_userRole");
    print("this is the _id notification page $_id");

    if (_userRole == 'magasinier') {
      url = 'http://172.20.10.2:4000/api/notifications/magasinier/$_id';
    } else if (_userRole == 'structureresponsable') {
      url = 'http://172.20.10.2:4000/api/notifications/responsable/$_id';
    } else if (_userRole == 'director') {
      url = 'http://172.20.10.2:4000/api/notifications/directeur/$_id';
    } else if (_userRole == 'consumer') {
      url = 'http://172.20.10.2:4000/api/notifications/consommateur/$_id';
    } else {
      url = 'http://172.20.10.2:4000/api/notifications/user/$_id';
      print("no id available");
    }

    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        setState(() {
          _notifications =
              data.map((json) => AppNotification.fromJson(json)).toList();
        });
      } else {
        throw Exception('Error fetching notifications: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      backgroundColor: Colors.white, // Background color set here
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final appNotification = _notifications[index];
          final notification = AppNotificationDetail(
            id: appNotification.id,
            message: appNotification.message,
            date: appNotification.date,
          );
          return NotificationCard(notification: notification);
        },
      ),
    );
  }
}
