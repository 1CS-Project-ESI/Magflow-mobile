import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/stats/command_graph.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:flutter_application_1/components/stats/card1.dart';
import 'package:flutter_application_1/components/stats/card2.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

String backendIP = dotenv.env['BACKEND_IP']!;

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int count = 0;
  int count1 = 0;
  double percentage = 0;
  double percentage1 = 0;
  String productName = "";
  int productQuantity = 0;
  List<int> commandCounts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // final _id = context.read<AuthProvider>().id;
    // print("the role is $_id");
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt('id');
    final _userRole = prefs.getString('role');

    try {
      final response3 = await fetchMostConsumableProductsByUser(_id!);
      setState(() {
        productName = response3["topNProducts"][0]["name"];
        productQuantity =
            response3["topNProducts"][0]["total_quantity_consumed"];
      });

      final response = await fetchUserCommandCounts(_id);
      final data = response;
      setState(() {
        count = data["validation_3_count"];
        count1 = data["validation_1_2_count"] + data["validation_0_count"];
        percentage = (data["validation_3_count"] * 100) /
            (data["validation_3_count"] +
                data["validation_1_2_count"] +
                data["validation_0_count"]);
        percentage1 =
            ((data["validation_1_2_count"] + data["validation_0_count"]) *
                    100) /
                (data["validation_3_count"] +
                    data["validation_1_2_count"] +
                    data["validation_0_count"]);
      });
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<Map<String, dynamic>> fetchMostConsumableProductsByUser(
      int _id) async {
    final url =
        'http://$backendIP:4000/api/statistics/mostconsumableproductsbyuser/$_id';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        // Parse total_quantity_consumed to int
        if (data['topNProducts'] is List) {
          for (var product in data['topNProducts']) {
            product['total_quantity_consumed'] =
                int.tryParse(product['total_quantity_consumed'].toString()) ??
                    0;
          }
        }
        return data;
      } else {
        throw Exception('Failed to load most consumable products');
      }
    } catch (error) {
      throw Exception('Error fetching most consumable products: $error');
    }
  }

  Future<Map<String, dynamic>> fetchUserCommandCounts(int _id) async {
    final url =
        'http://$backendIP:4000/api/statistics/getusercommandcounts/$_id';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse command counts to int
        data['validation_3_count'] =
            int.tryParse(data['validation_3_count'].toString()) ?? 0;
        data['validation_1_2_count'] =
            int.tryParse(data['validation_1_2_count'].toString()) ?? 0;
        data['validation_0_count'] =
            int.tryParse(data['validation_0_count'].toString()) ?? 0;
        if (data['commandCounts'] is List) {
          data['commandCounts'] = data['commandCounts']
              .map<int>((item) => int.tryParse(item.toString()) ?? 0)
              .toList();
        }
        return data;
      } else {
        throw Exception('Failed to load user command counts');
      }
    } catch (error) {
      throw Exception('Error fetching user command counts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Card1(
              title: "Le produit le plus consommable dans le stock",
              subtitle: productName,
              count: productQuantity,
            ),
            SizedBox(height: 10),
            Card2(
              title: "Nombre de commandes validée",
              percentage: percentage,
              count: count,
              color: Colors.green,
            ),
            SizedBox(height: 10),
            Card2(
              title: "Nombre de commandes en attente",
              percentage: percentage1,
              count: count1,
              color: Colors.yellow,
            ),
            SizedBox(height: 10),
            //  CommandGraph(commandCounts: commandCounts),
          ],
        ),
      ),
    );
  }
}
