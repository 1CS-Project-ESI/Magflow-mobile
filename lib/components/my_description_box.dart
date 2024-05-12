import 'package:flutter/material.dart';

class MyDescription extends StatelessWidget {
  const MyDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      child: Row(
        children: [
          //*****deleivry fee  */
          Column(
            children: [
              Text('\$0.99'),
              Text('delivry time'),
            ],
          ),

          ///*** deleivry time */
        ],
      ),
    );
  }
}
