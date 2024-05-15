// In a separate file (e.g., commande_card.dart)

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart'; // For date formatting
import 'package:flutter_application_1/models/commande.dart';

class CommandeCard extends StatelessWidget {
  final Commande commande;

  const CommandeCard(
      {super.key,
      required this.commande,
      required void Function(dynamic selected) onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(commande.date), // Format date
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Type de Commande: ',
                  style: const TextStyle(fontSize: 14.0),
                ),
                Text(
                  commande.typecommande,
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'ID: ',
                  style: const TextStyle(fontSize: 14.0),
                ),
                Text(
                  commande.id.toString(), // Convert id to string if needed
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Validation: ',
                  style: const TextStyle(fontSize: 14.0),
                ),
                Text(
                  commande.validation.toString(),
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Number: ',
                  style: const TextStyle(fontSize: 14.0),
                ),
                Text(
                  commande.number, // Assuming numbers is a string
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
