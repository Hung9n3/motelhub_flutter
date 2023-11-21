import 'package:flutter/material.dart';

class MyBoardingHouseComponent extends StatelessWidget {
  const MyBoardingHouseComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
            'this page is used for listview if is host, finding motel if guest'),
      ),
    );
  }
}
