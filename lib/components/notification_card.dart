
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final AppNotificationDetail notification;

  const NotificationCard({Key? key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap action if needed
      },
      child: Card(
        elevation: 4, // Added elevation for a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, right: 8.0),
                    child: Icon(
                      Icons.notification_important,
                      color: Color.fromARGB(255, 133, 54, 147), // Change the color of the icon
                    ),
                  ),
                  Expanded(
                    child: Text(
                      notification.message,
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                DateFormat('dd/MM/yyyy').format(notification.date),
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 120, 120, 120),
                ),
              ),
              const SizedBox(height: 8.0),
              
            ],
          ),
        ),
      ),
    );
  }
}

class AppNotificationDetail {
  final int id;
  final String message;
  final DateTime date;

  AppNotificationDetail({
    required this.id,
    required this.message,
    required this.date,
  });
}
