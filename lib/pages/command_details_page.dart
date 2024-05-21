import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/CommandTimeLine.dart'; // Adjust import path as necessary
import 'package:flutter_application_1/models/commande.dart'; // Adjust import path as necessary

class CommandDetailsPage extends StatelessWidget {
  final Commande commande;

  const CommandDetailsPage({Key? key, required this.commande}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Command Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Command Number: ${commande.number}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CommandTimeline(validation: commande.validation),
          ],
        ),
      ),
    );
  }
}
