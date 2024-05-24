import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalDivider extends StatelessWidget {
  String? text;
  HorizontalDivider({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
  margin: const EdgeInsets.fromLTRB(0,50,0,0), // Adjust the margin as needed
  child: Row(
    children: <Widget>[
      const Expanded(
        child: Divider(
          color: Colors.black, // Adjust the color as desired
          thickness: 1.0, // Adjust the thickness as needed
        ),
      ),
      Visibility(
        visible: text != null,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust the padding as needed
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(
              fontSize: 16.0, // Adjust the font size as desired
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
          ),
        ),
      )),
      const Expanded(
        child: Divider(
          color: Colors.black, // Adjust the color as desired
          thickness: 1.0, // Adjust the thickness as needed
        ),
      ),
    ],
  ),
);
  }
}