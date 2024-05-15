import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  const MySliverAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
      title: title,
      flexibleSpace: FlexibleSpaceBar(
        background: const Padding(
          padding: EdgeInsets.only(left: 20, right: 0, top: 0),
        ),
      ),
    );
  }
}
