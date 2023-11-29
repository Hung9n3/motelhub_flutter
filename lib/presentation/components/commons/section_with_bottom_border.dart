import 'package:flutter/material.dart';

class SectionWithBottomBorder extends StatelessWidget {
  final Widget child;
  const SectionWithBottomBorder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))),
      child: child,
    );
  }
}
