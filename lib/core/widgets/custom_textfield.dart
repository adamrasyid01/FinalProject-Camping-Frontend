import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController inputContorller;
  final String label;
  const CustomTextfield({
    super.key,
    required this.inputContorller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputContorller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        return value == null || value.isEmpty ? 'This field is required' : null;
      },
    );
  }
}
