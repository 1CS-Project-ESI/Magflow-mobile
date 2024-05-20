import "package:flutter/material.dart";
import "package:flutter_application_1/components/my_button.dart";
import "package:flutter_application_1/components/my_textfield.dart";
import "package:flutter_application_1/pages/ResetPW_page.dart";
import "package:flutter_application_1/pages/home_page.dart";

import 'dart:convert';
import 'package:http/http.dart'
    as http; // in case of probl = (run this in the cmd) dart pub add fetch_client

class ForgetPW extends StatefulWidget {
  final void Function()? onTap;

  const ForgetPW({super.key, required this.onTap});

  @override
  State<ForgetPW> createState() => _ForgetPWState();
}

class _ForgetPWState extends State<ForgetPW> {
  final TextEditingController emailController = TextEditingController();

  get resettoken => null;

  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController confirmpasswordController = TextEditingController();
  void _handelForgetPassword() async {
    final String email = emailController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.2:4000/api/auth/forgot-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Password reset email sent successfully
        final data = jsonDecode(response.body);
        final String resetToken = data['resettoken'];

        print(
            "**************reset token in page forget  page ***********************");
        print(resetToken);

        // print("resttoken is in the forget page ${resettoken} ");

        // Navigate to the ResetPasswordScreen and pass the resetToken
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(resetToken: resetToken),
          ),
        );
      } else {
        // Failed to send password reset email
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error resetting password: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Error occurred while sending the request
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending request: $e'),
        ),
      );
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
            Text("forget password "),
            //email
            const SizedBox(height: 25),
            MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false),
            // password
            const SizedBox(height: 25),
            // MyTextField(
            //     controller: passwordController,
            //     hintText: "password",
            //     obscureText: true),

            // const SizedBox(height: 25),
            // MyTextField(
            //     controller: confirmpasswordController,
            //     hintText: "confirm password",
            //     obscureText: true),

            // // Login Button (not functional yet)
            // const SizedBox(height: 25),
            MyButton(
              text: "Envoyer",
              onTap: _handelForgetPassword,
            ),

            // already have an account ? login in
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("LOGIN? ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Log In",
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
