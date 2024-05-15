// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/auth/auth_provider.dart';
// import 'package:flutter_application_1/components/my_current_location.dart';
// import 'package:flutter_application_1/components/my_description_box.dart';
// import 'package:flutter_application_1/components/my_drawer.dart';
// import 'package:flutter_application_1/models/commande.dart';
// import 'package:flutter_application_1/components/my_sliver_app_bar.dart';
// import 'package:flutter_application_1/components/commandCard.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart'; // For date formatting
// import 'package:flutter_application_1/auth/auth_provider.dart';
// import 'package:http/http.dart'
//     as http; // in case of probl = (run this in the cmd) dart pub add fetch_client

// // Import CommandeCa

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Commande> _commandes = []; // List to store fetched commandes
//   final List<Commande> _selectedCommandes = [];

//   // const commandes

//   static final staticCommandes = [
//     //  required this.date,
//     //   required this.typeCommande,
//     //   required this.id,
//     //   required this.validation,
//     //   required this.numbers,
//     Commande(
//       date: DateTime(2023, 5, 10),
//       typecommande: 'Office Supplies',
//       id: 2,
//       validation: 1,
//       number: "1",
//     ),
//     Commande(
//       date: DateTime(2023, 4, 25),
//       typecommande: 'IT Equipment',
//       id: 2,
//       validation: 2,
//       number: "2",
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _fetchCommandes(); // Fetch commandes on initState
//   }

//   // the user role and the id from the authProvider

//   Future<void> _fetchCommandes() async {
//     String url;
//     Map<String, String> queryParams = {};

//     // retrive the user role and the id from the provider
//     final _userRole = context.read<AuthProvider>().role;
//     print("the role is $_userRole");

//     final _id = context.read<AuthProvider>().id;
//     print("the id is $_id");

//     // we have only one magainier and one directore with no id of them in the bonCommand int ->
//     // send the role and based on the validation value -> getAllCommand for the roles
//     if (_userRole == 'magasinier' || _userRole == 'director') {
//       url =
//           'http://172.20.10.4:4000/api/bons/getAllBonCommandInterneFFordirectorMagazinier';
//       queryParams['role'] = _userRole;
//     } else if (_userRole == 'structureresponsable') {
//       final id_structureresponsable = context.read<AuthProvider>().id;
//       url =
//           'http://172.20.10.4:4000/api/bons/allcomandsforresposnable/$id_structureresponsable';
//     } else {
//       final id_consommateur = context.read<AuthProvider>().id;
//       url =
//           'http://172.20.10.4:4000/api/bons/consumer-commands/$id_consommateur';
//     }

//     final uri = Uri.parse(url).replace(queryParameters: queryParams);

//     try {
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as List<dynamic>;
//         setState(() {
//           _commandes = data
//               .map((commandeJson) {
//                 if (commandeJson == null) {
//                   return Commande.defaultCommande();
//                 } else {
//                   return Commande(
//                     date: commandeJson['date'] != null
//                         ? DateTime.parse(commandeJson['date'])
//                         : DateTime.now(),
//                     typecommande: commandeJson['typecommande'] ?? 'Default',
//                     id: commandeJson['id'] ?? "0",
//                     validation: commandeJson['validation'] ?? 0,
//                     number: commandeJson['number'] ?? '0',
//                   );
//                 }
//               })
//               .toList()
//               .cast<Commande>();
//         });
//       } else {
//         setState(() {
//           _commandes = [];
//         });
//         throw Exception(
//             'Error fetching commandes internes: ${response.statusCode}');
//       }
//     } catch (e) {
//       setState(() {
//         _commandes = [];
//       });
//       print('Error fetching commands: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Commandes'),
//       ),
//       // ... (drawer and other Scaffold elements)

//       body: ListView.builder(
//         itemCount: _commandes.length,
//         itemBuilder: (context, index) {
//           final commande = _commandes[index];
//           return CommandeCard(
//             commande: commande,
//             // Optional: Add callback to handle selecting a commande
//             onSelectionChanged: (selected) =>
//                 _handleSelection(commande, selected),
//           );
//         },
//       ),
//     );
//   }

//   void _handleSelection(Commande commande, bool isSelected) {
//     if (isSelected) {
//       setState(() {
//         _selectedCommandes.add(commande);
//       });
//     } else {
//       setState(() {
//         _selectedCommandes.remove(commande);
//       });
//     }
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
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:http/http.dart'
    as http; // in case of probl = (run this in the cmd) dart pub add fetch_client

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Commande> _commandes = []; // List to store fetched commandes
  final List<Commande> _selectedCommandes = [];

  static final staticCommandes = [
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

  @override
  void initState() {
    super.initState();
    _fetchCommandes(); // Fetch commandes on initState
  }

  Future<void> _fetchCommandes() async {
    String url;
    Map<String, String> queryParams = {};

    // Retrieve the user role and the id from the provider
    final _userRole = context.read<AuthProvider>().role;
    print("the role is $_userRole");

    final _id = context.read<AuthProvider>().id;
    print("the id is $_id");

    // We have only one magainier and one directore with no id of them in the bonCommand int ->
    // send the role and based on the validation value -> getAllCommand for the roles
    if (_userRole == 'magasinier' || _userRole == 'director') {
      url =
          'http://172.20.10.4:4000/api/bons/getAllBonCommandInterneFFordirectorMagazinier';
      queryParams['role'] = _userRole;
    } else if (_userRole == 'structureresponsable') {
      final id_structureresponsable = context.read<AuthProvider>().id;
      url =
          'http://172.20.10.4:4000/api/bons/allcomandsforresposnable/$id_structureresponsable';
    } else {
      final id_consommateur = context.read<AuthProvider>().id;
      url =
          'http://172.20.10.4:4000/api/bons/consumer-commands/$id_consommateur';
    }

    final uri = Uri.parse(url).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
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
                    id: commandeJson['id'] ?? 0,
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
          _commandes = [];
        });
        throw Exception(
            'Error fetching commandes internes: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _commandes = [];
      });
      print('Error fetching commands: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(), // Assign MyDrawer to the drawer property
      body: CustomScrollView(
        slivers: [
          MySliverAppBar(
            title: const Text("M A G F L O W "),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final commande = _commandes[index];
                return CommandeCard(
                  commande: commande,
                  onSelectionChanged: (selected) =>
                      _handleSelection(commande, selected),
                );
              },
              childCount: _commandes.length,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSelection(Commande commande, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedCommandes.add(commande);
      } else {
        _selectedCommandes.remove(commande);
      }
    });
  }
}
