import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/pages/prioritas_kriteria_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RekomendasiPage extends StatelessWidget {
  const RekomendasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Rekomendasi",
            style: AppTextStyle.medium20,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline, color: MyColor().customOrange),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.5), // Ketebalan garis
            child: Divider(
              height: 1,
              thickness: 1,
              color: MyColor().secondaryColor, // Warna garis
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed("prioritas_kriteria");
                },
                child: SvgPicture.asset(
                  "assets/images/dapatkanRekomendasi.svg",
                ),
              ),
            ],
          ),
        ));
  }
}
