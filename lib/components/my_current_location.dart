import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSerrchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Your location "),
        content: TextField(
            decoration: const InputDecoration(
          hintText: "search address... ",
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now ",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () => openLocationSerrchBox(context),
            child: Row(children: [
              // aaddres
              Text(
                "6901 Hotel ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // drop down menu

              Icon(Icons.keyboard_arrow_down_rounded),
            ]),
          ),
        ],
      ),
    );
  }
}
