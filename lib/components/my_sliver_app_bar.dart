

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/notification_page.dart'; // Ensure this import is correct
import 'package:flutter_application_1/pages/cart_page.dart'; // Ensure this import is correct

class MySliverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final TabBar? bottom;

  const MySliverAppBar({Key? key, required this.title, this.bottom})
      : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0) + 56);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      actions: [
        // Notification button
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
          },
          icon: const Icon(Icons.notifications_on_outlined),
        ),
        // Cart button
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
      backgroundColor: const Color(0xFFF7F7FC),
      title: Center(
        child: Image.asset(
          'assets/images/logo/magflow.png',
          width: 200,
          height: 200,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: kToolbarHeight + 16), // Extra space for padding
            if (bottom != null) bottom!,
          ],
        ),
      ),
      expandedHeight: kToolbarHeight +
          (bottom?.preferredSize.height ?? 0.0) +
          56, // Adjust the height as needed
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/pages/notification_page.dart'; // Ensure this import is correct
// import 'package:flutter_application_1/pages/cart_page.dart'; // Ensure this import is correct

// class MySliverAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final Widget title;
//   final TabBar bottom;

//   const MySliverAppBar({Key? key, required this.title, required this.bottom})
//       : super(key: key);

//   @override
//   Size get preferredSize =>
//       Size.fromHeight(kToolbarHeight + bottom.preferredSize.height + 56);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       pinned: true,
//       floating: true,
//       snap: true,
//       actions: [
//         // Notification button
//         IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => NotificationPage()),
//             );
//           },
//           icon: const Icon(Icons.notifications_on_outlined),
//         ),
//         // Cart button
//         IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => CartPage()),
//             );
//           },
//           icon: const Icon(Icons.shopping_cart),
//         ),
//       ],
//       backgroundColor: const Color(0xFFF7F7FC),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.start, // Adjust alignment
//         children: [
//           // Logo
//           Image.asset(
//             'assets/images/logo/magflow.png',
//             width: 200,
//             height: 200,
//           ),
//           SizedBox(width: 20), // Adjust the width as needed
//           title,
//         ],
//       ),
//       flexibleSpace: FlexibleSpaceBar(
//         background: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             const SizedBox(
//                 height: kToolbarHeight + 16), // Extra space for padding
//             bottom,
//           ],
//         ),
//       ),
//       expandedHeight: kToolbarHeight +
//           bottom.preferredSize.height +
//           56, // Adjust the height as needed
//     );
//   }
// }
