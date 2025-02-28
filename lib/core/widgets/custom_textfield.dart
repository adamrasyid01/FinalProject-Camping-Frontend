import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscureCharacter;
  final String hintText;
  final Color cursorColor;
  const CustomTextfield({
    super.key,
    required this.inputController,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.obscureCharacter = '*',
    required this.hintText,
    this.cursorColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // Menampilkan label di atas TextField
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8),
        TextFormField(
          cursorColor: cursorColor,
          controller: inputController,
          keyboardType: keyboardType,
          obscureText: isObscureText!,
          obscuringCharacter: obscureCharacter!,
          decoration: InputDecoration(
            fillColor: MyColor().secondaryColor.withOpacity(0.1),
            constraints:
                BoxConstraints(maxHeight: height * 0.065, maxWidth: width),
            filled: true,
            hintText: hintText,
            hintStyle: AppTextStyle.regular15.copyWith(
              color: Colors.grey, // Ubah warna sesuai keinginan
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: MyColor().secondaryColor, // Default border hijau
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: MyColor()
                    .secondaryColor, // Border tetap hijau saat tidak fokus
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),

              // Menghapus warna border saat fokus
            ),
          ),
          validator: (value) {
            return value == null || value.isEmpty
                ? 'This field is required'
                : null;
          },
        ),
      ],
    );
  }
}
