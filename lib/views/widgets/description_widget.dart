import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String text;

  const DescriptionWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Text(
        text,
        softWrap: true,
        style: const TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }
}