import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.readOnly = false,
    this.decoration,
    this.initialValue,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final InputDecoration? decoration;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      readOnly: readOnly,
      textAlign: TextAlign.center,
      cursorColor: Theme.of(context).colorScheme.primary,
      cursorWidth: 8,
      cursorHeight: 18,
      style: const TextStyle(color: Colors.white),
      decoration: decoration,
    );
  }
}
