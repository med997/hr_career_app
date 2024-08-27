import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            prefixIcon: Icon(
              icon,
              color: Colors.grey,
              size: 18,
            ),
            border: const OutlineInputBorder(),
            labelText: label,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
      ),
    );
  }
}
