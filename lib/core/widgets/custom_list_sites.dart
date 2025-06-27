import 'package:flutter/material.dart';

import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:shimmer/shimmer.dart';

class CampingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;
  final int reviews;
  final bool isBookmarked;
  final VoidCallback onBookmarkPressed;
  final VoidCallback? onDetailPressed; // Tambahan untuk tombol
  final int? ranking; // opsional: 1, 2, 3 dst
  

  const CampingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.isBookmarked,
    required this.onBookmarkPressed,
    this.onDetailPressed, // Tambahkan ini
    this.ranking,
 
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
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl.isNotEmpty
                      ? imageUrl
                      : 'https://via.placeholder.com/400x160?text=No+Image',
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 160,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.broken_image,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              if (ranking != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getBadgeColor(ranking!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Ranking $ranking',
                      style: AppTextStyle.bold14.copyWith(color: Colors.white),
                    ),
                  ),
                ),
        
            ],
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
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked ? Colors.orange : Colors.grey,
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
                      style: AppTextStyle.bold14
                          .copyWith(color: MyColor().customOrange),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "($reviews)",
                      style: AppTextStyle.bold14
                          .copyWith(color: MyColor().customOrange),
                    ),
                  ],
                ),

                // ✅ Tambahkan tombol di bawah
                CustomButton(
                  btnHeight: MediaQuery.of(context).size.height * 0.05,
                  btnText: "Lihat Detail",
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  btnColor: MyColor().primaryColor,
                  onPressed: onDetailPressed ?? () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color _getBadgeColor(int rank) {
  switch (rank) {
    case 1:
      return MyColor().customOrange; // Gold
    case 2:
      return const Color(0xFFC0C0C0); // Silver
    case 3:
      return const Color(0xFFCD7F32); // Bronze
    default:
      return Colors.black;
  }
}

class CampingCardSkeleton extends StatelessWidget {
  const CampingCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title bar
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),

                  // Location bar
                  Container(
                    width: 200,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),

                  // Rating bar
                  Row(
                    children: [
                      Container(width: 40, height: 12, color: Colors.white),
                      const SizedBox(width: 8),
                      Container(width: 30, height: 12, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Button
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
