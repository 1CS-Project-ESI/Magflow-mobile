


import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12), // Adjust padding for height and width
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Color(0xFF510A6D),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14, // Adjust font size
            ),
          ),
        ),
      ),
    );
  }
}
