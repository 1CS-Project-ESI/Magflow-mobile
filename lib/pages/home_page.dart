import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/components/my_drawer.dart';
import 'package:flutter_application_1/components/my_sliver_app_bar.dart';
import 'package:flutter_application_1/models/commande.dart';
import 'package:flutter_application_1/components/commandCard.dart';

import 'package:flutter_application_1/pages/command_details_page.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

String backendIP = dotenv.env['BACKEND_IP']!;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Commande> _commandes = [];
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
    _fetchCommandes();
  }

  Future<void> _fetchCommandes() async {
    String url;
    Map<String, String> queryParams = {};

    // final _userRole = context.read<AuthProvider>().role;
    // print("the role is $_userRole");

    // final _id = context.read<AuthProvider>().id;
    // print("the id is $_id");

    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt('id');
    final _userRole = prefs.getString('role');

    print(_id);
    print("the role is $_userRole");

    if (_userRole == 'magasinier' || _userRole == 'director') {
      url =
          'http://$backendIP:4000/api/bons/getAllBonCommandInterneFFordirectorMagazinier';
      queryParams['role'] = _userRole!;
    } else if (_userRole == 'structureresponsable') {
      final id_structureresponsable = context.read<AuthProvider>().id;
      url =
          'http://$backendIP:4000/api/bons/allcomandsforresposnable/$id_structureresponsable';
    } else {
      final id_consommateur = context.read<AuthProvider>().id;
      url =
          'http://$backendIP:4000/api/bons/consumer-commands/$id_consommateur';
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
      backgroundColor: Color(0xFFF7F7FC),
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          MySliverAppBar(
            title: const Text(""),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final commande = _commandes[index];
                return CommandeCard(
                  commande: commande,
                  onSelectionChanged: (selected) =>
                      _handleSelection(commande, selected),
                  onTap: () {
                    final _userRole = context.read<AuthProvider>().role;
                    if (_userRole == 'consumer') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CommandDetailsPage(commande: commande),
                        ),
                      );
                    }
                  },
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
