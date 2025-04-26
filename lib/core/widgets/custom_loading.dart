import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  final String asset;
  const CustomLoading({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Lottie.asset(
      asset,
      width: size.width, // 50% dari lebar layar
      height: size.height, // atau bisa juga size.height * 0.3
    );
  }
}
