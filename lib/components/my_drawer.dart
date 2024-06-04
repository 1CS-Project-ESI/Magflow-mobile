// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/components/my_drawer_tile.dart';
// import 'package:flutter_application_1/pages/settings_page.dart';
// import 'package:flutter_application_1/pages/login_page.dart';
// import 'package:flutter_application_1/custom_icons.dart';
// import 'package:flutter_application_1/pages/statistics_page.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
          
//           Container(
//             color: Colors.white,
//             padding: EdgeInsets.symmetric(),
//             child: Center(
//               child: Column(
//                 children: [
         
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         top: 35.0), 
//                     child: Center(
//                       child: Image.asset(
//                         'assets/images/logo/magflow.png',
//                         width: 200,
//                         height: 100,
//                       ),
//                     ),
//                   ),
//                   // Add any additional widgets for the top part here
//                 ],
//               ),
//             ),
//           ),
//           // Divider between top and bottom parts
//           Divider(color: Theme.of(context).colorScheme.secondary),
//           // Bottom part with menu items
//           Expanded(
//             child: Container(
//               color:
//                   Color(0xFF1F2036), // Background color with the specified code
//               child: Column(
//                 children: [
//                   // Home list tile
//                   MyDrawerTitle(
//                     text: "H O M E",
//                     icon: Icons.home,
//                     onTap: () => Navigator.pop(context),
//                     textColor: Colors.white, // Text color is white
//                   ),
//                   // Settings list tile
//                   MyDrawerTitle(
//                     text: "S E T T I N G S",
//                     icon: Icons.settings,
//                     onTap: () {
//                       Navigator.pop(context);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SettingsPage(),
//                         ),
//                       );
//                     },
//                     textColor: Colors.white, // Text color is white
//                   ),
//                   // Statistics list tile with custom icon
//                   MyDrawerTitle(
//                     text: "S T A T I S T I C S",
//                     icon: CustomIcons
//                         .query_stats_sharp, // Use the custom icon here
//                     onTap: () {
//                        Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => StatisticsPage()),
//                       );
//                       // Implement your navigation logic here
//                     },
//                     textColor: Colors.white, // Text color is white
//                   ),
//                   // Logout list tile
//                   MyDrawerTitle(
//                     text: "L O G O U T",
//                     icon: Icons.logout,
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginPage()),
//                       );
//                     },
//                     textColor: Colors.white, // Text color is white
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomIcons {
//   static const IconData query_stats_sharp =
//       IconData(0xEBEF, fontFamily: 'MaterialIcons');
// }



import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_drawer_tile.dart';
import 'package:flutter_application_1/pages/settings_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/custom_icons.dart';
import 'package:flutter_application_1/pages/statistics_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

String backendIP = dotenv.env['BACKEND_IP']!;

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo/magflow.png',
                        width: 200,
                        height: 100,
                      ),
                    ),
                  ),
                  // Add any additional widgets for the top part here
                ],
              ),
            ),
          ),
          // Divider between top and bottom parts
          Divider(color: Theme.of(context).colorScheme.secondary),
          // Bottom part with menu items
          Expanded(
            child: Container(
              color:
                  Color(0xFF1F2036), // Background color with the specified code
              child: Column(
                children: [
                  // Home list tile
                  MyDrawerTitle(
                    text: "H O M E",
                    icon: Icons.home,
                    onTap: () => Navigator.pop(context),
                    textColor: Colors.white, // Text color is white
                  ),
                  // Settings list tile
                  MyDrawerTitle(
                    text: "S E T T I N G S",
                    icon: Icons.settings,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                    textColor: Colors.white, // Text color is white
                  ),
                  // Statistics list tile with custom icon
                  MyDrawerTitle(
                    text: "S T A T I S T I C S",
                    icon: CustomIcons.query_stats_sharp, // Use the custom icon here
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => StatisticsPage()),
                      );
                      // Implement your navigation logic here
                    },
                    textColor: Colors.white, // Text color is white
                  ),
                  // Logout list tile
                  MyDrawerTitle(
                    text: "L O G O U T",
                    icon: Icons.logout,
                    onTap: () async {
                      await handleLogout(context);
                    },
                    textColor: Colors.white, // Text color is white
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken != null) {
      try {
        final response = await http.post(
          Uri.parse('http://${dotenv.env['BACKEND_IP']!}:4000/api/auth/logout'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          // Logout successful, remove token from shared preferences
          await prefs.remove('accessToken');
          print("Logout successful!");

          // Navigate to login page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          throw Exception('Failed to logout');
        }
      } catch (error) {
        print("Error during logout: $error");
        // Handle errors (e.g., display error message)
      }
    } else {
      // No access token found, directly navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}

class CustomIcons {
  static const IconData query_stats_sharp =
      IconData(0xEBEF, fontFamily: 'MaterialIcons');
}
