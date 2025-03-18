import 'package:flutter/material.dart';

import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';

class CampingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;
  final int reviews;
  final bool isBookmarked; // Tambahkan ini
  final VoidCallback onBookmarkPressed;

  const CampingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.isBookmarked, // Tambahkan ini
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: MyColor().customWhite,
      shadowColor: MyColor().customGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyle.semiBold18,
                        softWrap: true,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border, // Ikon berubah
                        color: isBookmarked ? Colors.orange : Colors.grey, // Warna berubah
                      ),
                      onPressed: onBookmarkPressed,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: AppTextStyle.regular12.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: MyColor().customOrange, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: AppTextStyle.bold14.copyWith(color: MyColor().customOrange),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "($reviews)",
                      style: AppTextStyle.bold14.copyWith(color: MyColor().customOrange),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
