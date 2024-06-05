

// home_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:flutter_application_1/components/productCard.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/components/my_drawer.dart';
import 'package:flutter_application_1/components/my_sliver_app_bar.dart';
import 'package:flutter_application_1/models/commande.dart';
import 'package:flutter_application_1/components/commandCard.dart';
import 'package:flutter_application_1/pages/command_details_page.dart';
import 'package:flutter_application_1/pages/cart_page.dart'; // Import the CartPage
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/providers/cart_provider.dart'; // Import the CartProvider
import '../models/product.dart';

String backendIP = dotenv.env['BACKEND_IP']!;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Commande> _commandes = [];
  List<Product> _products = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    await _fetchCommandes();
    await _fetchProducts();
  }

  Future<void> _fetchCommandes() async {
    String url;
    Map<String, String> queryParams = {};

    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt('id');
    final _userRole = prefs.getString('role');

    if (_userRole == 'magasinier' || _userRole == 'director') {
      url =
          'http://$backendIP:4000/api/bons/getAllBonCommandInterneFFordirectorMagazinier';
      queryParams['role'] = _userRole!;
    } else if (_userRole == 'structureresponsable') {
      url = 'http://$backendIP:4000/api/bons/allcomandsforresposnable/$_id';
    } else {
      url = 'http://$backendIP:4000/api/bons/consumer-commands/$_id';
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

  Future<void> _fetchProducts() async {
    final uri = Uri.parse('http://$backendIP:4000/api/store/product/all');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['products'] as List<dynamic>;
        setState(() {
          _products = data.map((json) => Product.fromJson(json)).toList();
        });
      } else {
        setState(() {
          _products = []; // Set an empty list if fetching products fails
        });
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _products = []; // Set an empty list if an exception occurs
      });
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      drawer: const MyDrawer(),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              MySliverAppBar(
                title: const Text(""),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                  ),
                ],
                bottom: TabBar(
                  controller: _tabController,
                  labelColor: const Color.fromARGB(255, 50, 24, 90),
                  indicatorColor: const Color.fromARGB(255, 50, 24, 90),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("My Commands"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Products"),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: _commandes.length,
                itemBuilder: (context, index) {
                  final commande = _commandes[index];
                  return CommandeCard(
                    commande: commande,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommandDetailsPage(commande: commande),
                        ),
                      );
                    },
                    onSelectionChanged: (bool) {},
                  );
                },
              ),
              ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return ProductCard(
                    product: product,
                    onAddToCart: () {
                      context.read<CartProvider>().addProduct(product);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
