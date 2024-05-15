// class HomePage extends StatefulWidget {
//   const HomePage({super.key, required role});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final role = Provider.of<AuthProvider>(context).role;

//     return Scaffold(
//       drawer: const MyDrawer(), // like a navbar -> should be a component
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           MySliverAppBar(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // my current location
//                   Divider(
//                     indent: 25,
//                     endIndent: 25,
//                     color: Theme.of(context).colorScheme.secondary,
//                   ),
//                   //my current location
//                   // MyCurrentLocation(),

//                   // /// description box
//                   Text('Your Role: $role'), // Display the retrieved role

//                   ///
//                 ],
//               ),
//               title: Text("title"))
//         ],
//         body: Container(
//           color: Color.fromARGB(255, 202, 195, 195),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:flutter_application_1/components/my_current_location.dart';
import 'package:flutter_application_1/components/my_description_box.dart';
import 'package:flutter_application_1/components/my_drawer.dart';
import 'package:flutter_application_1/models/commande.dart';
import 'package:flutter_application_1/components/my_sliver_app_bar.dart';
import 'package:flutter_application_1/components/commandCard.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For date formatting

import 'package:http/http.dart'
    as http; // in case of probl = (run this in the cmd) dart pub add fetch_client

// Import CommandeCa

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Commande> _commandes = []; // List to store fetched commandes
  final List<Commande> _selectedCommandes = [];

  // const commandes

  static final staticCommandes = [
    //  required this.date,
    //   required this.typeCommande,
    //   required this.id,
    //   required this.validation,
    //   required this.numbers,
    Commande(
      date: DateTime(2023, 5, 10),
      typecommande: 'Office Supplies',
      id: 2,
      validation: 1,
      number: "1",
    ),
    Commande(
      date: DateTime(2023, 4, 25),
      typecommande: 'IT Equipment',
      id: 2,
      validation: 2,
      number: "2",
    ),
  ];

  // get http => null; // List to track "selected" commandes

  @override
  void initState() {
    super.initState();
    _fetchCommandes(); // Fetch commandes on initState
  }

  Future<void> _fetchCommandes() async {
    final response = await http
        .get(Uri.parse('http://172.20.10.4:4000/api/bons/allcommandsinterne'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      // print('this is the data $data');
      setState(() {
        _commandes = data
            .map((commandeJson) {
              if (commandeJson == null) {
                return Commande.defaultCommande();
              } else {
                return Commande(
                  date: commandeJson['date'] != null
                      ? DateTime.parse(commandeJson['date'])
                      : DateTime.now(),
                  typecommande: commandeJson['typecommande'] ?? 'Default',
                  id: commandeJson['id'] ?? "0",
                  validation: commandeJson['validation'] ?? 0,
                  number: commandeJson['number'] ?? '0',
                );
              }
            })
            .toList()
            .cast<Commande>();
      });
    } else {
      setState(() {
        _commandes = staticCommandes; // Use static data in case of API failure
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Commandes'),
      ),
      // ... (drawer and other Scaffold elements)

      body: ListView.builder(
        itemCount: _commandes.length,
        itemBuilder: (context, index) {
          final commande = _commandes[index];
          return CommandeCard(
            commande: commande,
            // Optional: Add callback to handle selecting a commande
            onSelectionChanged: (selected) =>
                _handleSelection(commande, selected),
          );
        },
      ),
    );
  }

  void _handleSelection(Commande commande, bool isSelected) {
    if (isSelected) {
      setState(() {
        _selectedCommandes.add(commande);
      });
    } else {
      setState(() {
        _selectedCommandes.remove(commande);
      });
    }
  }
}
