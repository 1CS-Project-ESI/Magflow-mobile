import 'package:flutter/material.dart';

class CommandTimeline extends StatelessWidget {
  final int validation;

  const CommandTimeline({Key? key, required this.validation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          timelineRow("Order created ", validation >= 0),
          timelineRow("Order In Process: validated by Responsable Struct",
              validation >= 1),
          timelineRow(
              "Order Processed :validated by Director", validation >= 2),
          timelineRow("Order validated by magasinier ", validation >= 3),
          timelineLastRow("Order Delivered", validation >= 4),
        ],
      ),
    );
  }

  Widget timelineRow(String title, bool completed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: completed ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 3,
              height: 50,
              decoration: BoxDecoration(
                color: completed ? Colors.green : Colors.grey,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14, color: completed ? Colors.black : Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget timelineLastRow(String title, bool completed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: completed ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 3,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14, color: completed ? Colors.black : Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
