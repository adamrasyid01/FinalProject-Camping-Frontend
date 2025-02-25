
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  static const Color primaryColor = Color(0xFF14777D);

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), minimumSize: const Size(double.infinity, 48)),
      child: Text(
        text, style: TextStyle(color:Colors.white, fontSize: 18),
      ),
    );
  }
}
