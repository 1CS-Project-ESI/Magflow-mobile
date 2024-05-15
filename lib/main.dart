import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/login_or_register.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:flutter_application_1/pages/ForgetPW_page.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MultiProvider(
    // Use MultiProvider for multiple providers
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(
          create: (context) => AuthProvider()), // Create AuthProvider instance
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(), // Set LoginPage as initial home
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
