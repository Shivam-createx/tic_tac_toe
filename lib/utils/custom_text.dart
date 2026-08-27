import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final List<Shadow> textShadow;
  const CustomText({super.key, required this.text, required this.textShadow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 50,
        fontWeight: FontWeight.bold,
        shadows: textShadow,
      ),
    );
  }
}
