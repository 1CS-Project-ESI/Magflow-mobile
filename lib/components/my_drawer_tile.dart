import 'package:flutter/material.dart';

class MyDrawerTitle extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  const MyDrawerTitle({
    // create the const of ma DrawerTitle -> they gonna be returned in the retun stat
    super.key,
    required this.text,
    required this.icon,
    required this.onTap, required Color textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
