import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SwipeableWithDeleteButton extends StatelessWidget {
  final Widget child;
  const SwipeableWithDeleteButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              )
            ]),
        child: child);
  }
}
