import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSearchTap;
  final String? hintText;

  const SearchInput({
    super.key,
    this.controller,
    this.onSearchTap,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.search, color: Colors.grey),
          onPressed: onSearchTap,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
    );
  }
}
