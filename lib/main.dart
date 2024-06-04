// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/auth/auth_provider.dart';
// import 'package:flutter_application_1/pages/home_page.dart';
// import 'package:flutter_application_1/pages/login_page.dart';
// import 'package:flutter_application_1/pages/splash_screen.dart';
// import 'package:flutter_application_1/themes/theme_provider.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   await dotenv.load();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => ThemeProvider()),
//         ChangeNotifierProvider(create: (context) => AuthProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }

//   Future<void> _initializeApp() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     await authProvider.loadUserCredentials();

//     Future.delayed(const Duration(seconds: 5), () {
//       setState(() {
//         _isInitialized = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: _isInitialized
//           ? authProvider.id > 0
//               ? const HomePage()
//               : const LoginPage()
//           :  SplashScreen(),
//       theme: Provider.of<ThemeProvider>(context).themeData,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/pages/home_page.dart';
// import 'package:flutter_application_1/pages/login_page.dart';
// import 'package:flutter_application_1/pages/splash_screen.dart';
// import 'package:flutter_application_1/themes/theme_provider.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<bool> isUserLoggedIn() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getBool('isLoggedIn') ?? false;
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load();

//   final isLoggedIn = await isUserLoggedIn();

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//       ],
//       child: MyApp(isLoggedIn: isLoggedIn),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   final bool isLoggedIn;

//   const MyApp({super.key, required this.isLoggedIn});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() {
//         _isInitialized = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: _isInitialized
//           ? widget.isLoggedIn
//               ? const HomePage()
//               : const LoginPage()
//           :  SplashScreen(),
//       theme: Provider.of<ThemeProvider>(context).themeData,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('accessToken');
  print(token);
  return token != null;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  final isLoggedIn = await isUserLoggedIn();
  final authProvider = AuthProvider();
  authProvider.setLoggedIn(isLoggedIn);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => authProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isInitialized
          ? authProvider.isLoggedIn
              ? const HomePage()
              : const LoginPage()
          : SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
