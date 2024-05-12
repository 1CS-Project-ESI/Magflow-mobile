import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_current_location.dart';
import 'package:flutter_application_1/components/my_description_box.dart';
import 'package:flutter_application_1/components/my_drawer.dart';
import 'package:flutter_application_1/components/my_sliver_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(), // like a navbar -> should be a component
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // my current location
                  Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  //my current location
                  MyCurrentLocation(),

                  /// description box
                  MyDescription(),

                  ///
                ],
              ),
              title: Text("title"))
        ],
        body: Container(
          color: Color.fromARGB(255, 202, 195, 195),
        ),
      ),
    );
  }
}
