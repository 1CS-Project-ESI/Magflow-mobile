


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/commande.dart';

class CommandeCard extends StatelessWidget {
  final Commande commande;
  final Function(bool) onSelectionChanged;
  final VoidCallback onTap;

  const CommandeCard({
    Key? key,
    required this.commande,
    required this.onSelectionChanged,
    required this.onTap,
  }) : super(key: key);

  String _getValidationStatus(int validationValue) {
    switch (validationValue) {
      case 1:
        return 'Validated by Responsable Struct';
      case 2:
        return 'Validated by Director';
      case 3:
        return 'Validated by Magasinier';
      case 0:
        return 'Not Validated';
      default:
        return 'Unknown Validation Status';
    }
  }


    Color _getValidationColor(int validationValue) {
    switch (validationValue) {
      case 1:
        return Colors.orange; // Orange for validation status 1
      case 2:
        return Colors.orangeAccent; // Lighter orange for validation status 2
      case 3:
        return Colors.green; // Green for validation status 3
      case 0:
      return Colors.red;
      default:
        return Colors.red; // Red for validation status 0
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4, // Added elevation for a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(commande.date),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
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
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                    commande.id.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Validation Status: ',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    _getValidationStatus(commande.validation),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: _getValidationColor(commande.validation),
                    ),
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
                    commande.number,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





