import 'package:flutter/material.dart';

class ItemExpansion extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final IconData? icon;
  final int? itemCount;
  const ItemExpansion(
      {super.key,
      required this.children,
      this.icon,
      required this.title,
      this.itemCount = 0});

  @override
  State<ItemExpansion> createState() => _ItemExpansionState();
}

class _ItemExpansionState extends State<ItemExpansion> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(8),
      title: Text(widget.title),
      leading: Icon(widget.icon),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${widget.itemCount}'),
          Icon(
            _customTileExpanded
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_up,
          ),
        ],
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
      children: widget.children,
    );
  }
}
