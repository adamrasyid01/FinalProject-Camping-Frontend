import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

class CustomSlider extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final myColor = MyColor(); // Ambil instance MyColor

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.poppinsSemiBold14,
        ),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0.0,
          max: 10.0,
          divisions: 10,
          label: value.toStringAsFixed(1),
          activeColor: myColor.greenCustom, // Warna aktif dari MyColor
          inactiveColor: myColor.customGrey, // Warna tidak aktif dari MyColor
        ),
        SizedBox(height: 12)
      ],
    );
  }
}
