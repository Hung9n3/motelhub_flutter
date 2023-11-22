import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AreaDetailPage extends StatelessWidget {
  final int areaId;
  const AreaDetailPage({super.key, this.areaId = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Area Detail'),
      ),
      body: const Center(child: Text('this is area detail')),
    );
  }
}