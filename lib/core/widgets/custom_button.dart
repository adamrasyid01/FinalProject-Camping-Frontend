import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final double? btnWidth;
  final double? btnHeight;
  final Color btnTextColor;
  final Color? btnColor; // Tambahkan parameter untuk warna tombol
  final double? fontSize;
  final VoidCallback onPressed;
  static const Color primaryColor = Color(0xFF14777D);

  const CustomButton({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.btnTextColor = Colors.white,
    this.btnColor, // Warna tombol bisa diubah dari luar
    this.fontSize,
    this.btnWidth,
    this.btnHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor ??
            primaryColor, // Gunakan warna dari parameter atau default
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: Size(
          btnWidth ?? MediaQuery.of(context).size.width,
          btnHeight ?? MediaQuery.of(context).size.height * 0.06,
        ),
        elevation: 1.0,
      ),
      child: Center(
        child: Text(
          btnText,
          style: AppTextStyle.semiBold16
              .copyWith(color: btnTextColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
