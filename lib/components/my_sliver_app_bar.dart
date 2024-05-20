
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/notification_page.dart'; // Ensure this import is correct

class MySliverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  const MySliverAppBar({Key? key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      actions: [
        Row(
          children: [
            // Logo
            Padding(
              padding: EdgeInsets.only(right: 50.0),
              child: Image.asset(
                'assets/images/logo/magflow.png',
                width: 200,
                height: 200,
              ),
            ),
            // Notification button
            IconButton(
              onPressed: () {
                // When the notification icon is pressed, navigate to NotificationPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              icon: const Icon(Icons.notifications_on_outlined),
            ),
          ],
        ),
      ],
      backgroundColor: Color(0xFFF7F7FC),
      title: title,
      flexibleSpace: const FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(left: 20, right: 0, top: 0),
        ),
      ),
    );
  }
}
