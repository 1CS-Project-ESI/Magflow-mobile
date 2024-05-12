import "package:flutter/material.dart";
import "package:flutter_application_1/pages/login_page.dart";
import "package:flutter_application_1/pages/ForgetPW_page.dart";

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // first :initialy show login page
  bool showLoginPage = true;

  // second : toggle between the 2 pages
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePage);
    } else {
      return ForgetPW(onTap: togglePage);
    }
  }
}
