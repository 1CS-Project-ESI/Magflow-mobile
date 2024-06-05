import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_application_1/providers/cart_provider.dart';

String backendIP = dotenv.env['BACKEND_IP']!;

class ProductTypeDialog extends StatefulWidget {
  final VoidCallback onDecharge;
  final VoidCallback onInterne;
  final CartProvider cartProvider;

  const ProductTypeDialog({
    Key? key,
    required this.onDecharge,
    required this.onInterne,
    required this.cartProvider,
  }) : super(key: key);

  @override
  _ProductTypeDialogState createState() => _ProductTypeDialogState();
}

class _ProductTypeDialogState extends State<ProductTypeDialog> {
  String? _commandType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Product Type'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              widget.onDecharge();
              setState(() {
                _commandType = 'Commande Decharges';
              });
            },
            child: Text('Decharge'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              widget.onInterne();
              setState(() {
                _commandType = 'Commande Interne';
              });
            },
            child: Text('Interne'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _commandType != null
                ? () {
                    _createCommand(context);
                  }
                : null,
            child: Text('Create Command'),
          ),
        ],
      ),
    );
  }

  Future<void> _createCommand(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final _userId = prefs.getInt('id');
    try {
      final url = Uri.parse('http://$backendIP:4000/api/bons/create-bon-commande-interne/$_userId');
      final produitsCommandes = widget.cartProvider.products.map((product) {
        final quantity = widget.cartProvider.getProductQuantity(product);
        return {
          'id_produit': product.id,
          'orderedquantity': quantity,
        };
      }).toList();

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'number': _generateRandomNumber(),
          'date': _getCurrentDate(),
          'produitsCommandes': produitsCommandes,
          'typecommande': _commandType,
        }),
      );

      if (response.statusCode == 200) {
        // Command created successfully
        print('Command created successfully');
        Navigator.of(context).pop();
      } else {
        // Handle error
        print('Error creating command: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating command: $e');
    }
  }

  String _generateRandomNumber() {
    final randomNumber = 100000 + Random().nextInt(900000);
    return randomNumber.toString();
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }
}