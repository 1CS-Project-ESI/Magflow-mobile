import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_application_1/components/my_button.dart";
import "package:flutter_application_1/components/my_textfield.dart";

import "home_page.dart";
import 'dart:convert';
import 'package:http/http.dart'
    as http; // in case of probl = (run this in the cmd) dart pub add fetch_client

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleLogin() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://172.20.10.4:4000/api/auth/login'), // Replace with your backend API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful
        final data = jsonDecode(response.body);
        final token = data['accessToken'];
        final role = data['role'];

        // Store the token and role in state management (e.g., using Provider)
        // Example using Provider:
        // context.read<AuthProvider>().setToken(token);
        // context.read<AuthProvider>().setRole(role);

        // Navigate to the home page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(
              role: null,
            ),
          ),
        );
      } else {
        // Login failed
        final errorMessage = jsonDecode(response.body)['message'];
        // Display the error message to the user
        print(errorMessage);
      }
    } catch (e) {
      // Handle network or other exceptions
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.lock_open_rounded,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            Text("M A G F L O W"),

            //email
            const SizedBox(height: 25),
            MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false),
            // password
            const SizedBox(height: 25),
            MyTextField(
                controller: passwordController,
                hintText: "password",
                obscureText: true),

            // Login Button (not functional yet)
            const SizedBox(height: 25),
            MyButton(
              text: "Sing IN ",
              onTap: _handleLogin,
            ),

            // not register member
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Mot De passe oublie?  ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("forget password",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
