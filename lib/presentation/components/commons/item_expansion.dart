import 'package:flutter/material.dart';

class ItemExpansion extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final IconData? icon;
  const ItemExpansion({super.key, required this.children, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(8),
      title: Text(title),
      leading: Icon(icon),
      children: children
    );
  }
}