import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCampingWidget extends StatelessWidget {
  const EmptyCampingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColor().customOrange), // Gunakan MyColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/emptyBookmark.svg"),
          const SizedBox(height: 16),
          Text(
            "Anda masih belum memiliki tempat camping yang tersimpan.",
            textAlign: TextAlign.left,
            style: AppTextStyle.regular12.copyWith(
                color: MyColor().customOrange), // Gunakan AppTextStyle
          ),
        ],
      ),
    );
  }
}
