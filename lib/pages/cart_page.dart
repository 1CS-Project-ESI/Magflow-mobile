// lib/pages/cart_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

String backendIP = dotenv.env['BACKEND_IP']!;

class CartPage extends StatelessWidget {
  get http => null;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final cartItem = cart.items[index];
          return ListTile(
            title: Text(cartItem.product.name),
            subtitle: Text('Quantity: ${cartItem.quantity}'),
            trailing: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                cart.removeItem(cartItem.product.id);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Text('Confirm Order'),
            onPressed: () async {
              // final token = await getToken();
              // final userId = await UserID();
              final prefs = await SharedPreferences.getInstance();
              final userId = prefs.getInt('id');
              final _userRole = prefs.getString('role');
              final token = prefs.getString('token');

              print(userId);
              print("the role is $_userRole");

              final now = DateTime.now().toIso8601String();
              final randomNumber = (100000 + (100000 * 0.1)).toInt().toString();
              final productsOrdered = cart.items
                  .map((item) => {
                        'id_produit': item.product.id,
                        'orderedquantity': item.quantity,
                      })
                  .toList();

              final response = await http.post(
                Uri.parse(
                    'http://$backendIP:4000/api/bons/create-bon-commande-interne/$userId'),
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
                body: jsonEncode({
                  'number': randomNumber,
                  'date': now,
                  'produitsCommandes': productsOrdered,
                }),
              );

              if (response.statusCode == 200) {
                cart.clearCart();
                Navigator.pushNamed(context, '/success');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to confirm order')),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
