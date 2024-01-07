import 'package:flutter/widgets.dart';

class FormContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const FormContainer({super.key, required this.child, this.maxWidth = 800});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(  
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: const EdgeInsets.all(30),
          child: child,
        ),
      ),
    );
  }
}