import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_slider.dart';

class PrioritasKriteriaPage extends StatefulWidget {
  const PrioritasKriteriaPage({super.key});

  @override
  State<PrioritasKriteriaPage> createState() => _PrioritasKriteriaPageState();
}

class _PrioritasKriteriaPageState extends State<PrioritasKriteriaPage> {
  double keamanan = 0.5;
  double kenyamanan = 0.5;
  double kebersihan = 0.5;
  double kemudahanTransportasi = 0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Prioritas Kriteria",
            style: AppTextStyle.medium20,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30.0,
            ), // Tombol back
            onPressed: () {
              context
                  .pop(); // Menggunakan GoRouter untuk kembali ke halaman sebelumnya
            },
          ),
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
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 12.0),
                child: Text(
                  "Masukkan urutan prioritas kriteriamu",
                  style: AppTextStyle.bold24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyColor().customGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Terdapat 4 kriteria terkait pemilihan lokasi camping. Silahkan isi seberapa penting kriteria berdasarkan preferensi Anda dengan menggeser perbandingan di bawah ini.",
                  style: AppTextStyle.regular12.copyWith(
                    color: MyColor().darkGrey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 8.0, 24.0),
                child: Column(
                  children: [
                    CustomSlider(
                      title: "Keamanan",
                      value: keamanan,
                      onChanged: (value) => setState(() => keamanan = value),
                    ),
                    CustomSlider(
                      title: "Kenyamanan",
                      value: kenyamanan,
                      onChanged: (value) => setState(() => kenyamanan = value),
                    ),
                    CustomSlider(
                      title: "Kebersihan",
                      value: kebersihan,
                      onChanged: (value) => setState(() => kebersihan = value),
                    ),
                    CustomSlider(
                      title: "Kemudahan Transportasi",
                      value: kemudahanTransportasi,
                      onChanged: (value) =>
                          setState(() => kemudahanTransportasi = value),
                    ),
                  ],
                ),
              ),
              CustomButton(btnText: "Temukan Rekomendasi", onPressed: () {})
            ],
          ),
        ));
  }
}
