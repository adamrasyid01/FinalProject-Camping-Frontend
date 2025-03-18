import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_svg/svg.dart';

class CustomListWisata extends StatelessWidget {
  const CustomListWisata({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.totalCamps,
  });

  final String imageUrl;
  final String name;
  final int totalCamps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 16 / 9, // Menjaga rasio gambar
          child: Stack(
            fit: StackFit.expand, // Mengisi seluruh ruang yang tersedia
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover, // Pastikan gambar mengisi seluruh area
              ),
              _buildGradient(),
              _buildTitleAndSubtitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(0),
              Colors.transparent,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0, 0.5, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.transparent, // Warna latar belakang transparan
              borderRadius: BorderRadius.circular(12), // Border radius
              border: Border.all(color: Colors.white, width: 2), // Border putih
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/camping.svg',
                ),
                const SizedBox(width: 4),
                Text(
                  '$totalCamps',
                  style: AppTextStyle.semiBold20.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
