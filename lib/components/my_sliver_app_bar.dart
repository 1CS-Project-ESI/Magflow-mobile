import "package:flutter/material.dart";

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySliverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        // cart button
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_on_outlined),
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      // foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("M A G F L O W "),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(left: 20, right: 0, top: 0),
          child: child,
        ),
        
      ),
    );
  }
}
