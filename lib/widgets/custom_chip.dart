import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/utils/text_styles.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF14777D) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Text(
          label,
          style: (isSelected ? AppTextStyle.bold14 : AppTextStyle.regular14)
              .copyWith(
            color: isSelected ? Colors.white : const Color(0xFF8A8A8E),
          ),
        ),
      ),
    );
  }
}
