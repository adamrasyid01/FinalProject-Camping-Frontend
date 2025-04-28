import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_dialog.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_loading.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_bloc.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_event.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_state.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RekomendasiPage extends StatefulWidget {
  const RekomendasiPage({super.key});

  @override
  State<RekomendasiPage> createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
  final MyColor myColor = MyColor();
  int selectedRating = 0; // Default value
  String selectedLocation = ""; // Default value
  List<String> locations = [
    "Kabupaten Bangkalan",
    "Kabupaten Banyuwangi",
    "Kabupaten Blitar",
    "Kabupaten Bojonegoro",
    "Kabupaten Bondowoso",
    "Kabupaten Gresik",
    "Kabupaten Jember",
    "Kabupaten Jombang",
    "Kabupaten Kediri",
    "Kabupaten Lamongan",
    "Kabupaten Lumajang",
    "Kabupaten Madiun",
    "Kabupaten Magetan",
    "Kabupaten Malang",
    "Kabupaten Mojokerto",
    "Kabupaten Nganjuk",
    "Kabupaten Ngawi",
    "Kabupaten Pacitan",
    "Kabupaten Pamekasan",
    "Kabupaten Pasuruan",
    "Kabupaten Ponorogo",
    "Kabupaten Probolinggo",
    "Kabupaten Sampang",
    "Kabupaten Sidoarjo",
    "Kabupaten Situbondo",
    "Kabupaten Sumenep",
    "Kabupaten Trenggalek",
    "Kabupaten Tuban",
    "Kabupaten Tulungagung",
    "Kota Batu",
    "Kota Blitar",
    "Kota Kediri",
    "Kota Madiun",
    "Kota Malang",
    "Kota Mojokerto",
    "Kota Pasuruan",
    "Kota Probolinggo",
    "Kota Surabaya",
  ];
  @override
  void initState() {
    super.initState();
    context.read<AHPResultBloc>().add(AHPResultEventGetAHPResult());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Rekomendasi",
            style: AppTextStyle.medium20,
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline, color: MyColor().customOrange),
              onPressed: () {
                showCustomDialog(
                  context: context,
                  onConfirm: () {},
                  title: 'Rumus yang digunakan',
                  content:
                      '1. Sistem menetapkan nilai dari kriteriamu sebagai bobot.\n'
                      '2. Sistem akan menormalisasi bobot untuk mendapatkan bobot setiap kriteria.\n'
                      '3. Sistem akan menghitung bobot dari alternatif berdasarkan setiap kriteria.\n'
                      '4. Sistem akan mengalikan bobot kriteriamu dengan bobot alternatif untuk setiap kriteria, lalu jumlahkan hasilnya untuk mendapatkan skor total setiap alternatif.',
                  icon: Icons.info_outline,
                  titleStyle: AppTextStyle.bold18,
                  contentStyle: AppTextStyle.regular14,
                  alignContent: TextAlign.justify,
                  iconBackgroundColor: MyColor().customOrange,
                );
              },
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
              GestureDetector(
                onTap: () async {
                  final result =
                      await context.pushNamed<bool>("prioritas_kriteria");

                  if (result == true) {
                    context
                        .read<AHPResultBloc>()
                        .add(AHPResultEventGetAHPResult());
                  }
                },
                child: SvgPicture.asset(
                  "assets/images/dapatkanRekomendasi.svg",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hasil Rekomendasi",
                    style: AppTextStyle.semiBold18.copyWith(
                      color: MyColor().black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Pastikan ini true untuk fleksibilitas tinggi
                        constraints: BoxConstraints(
                          minHeight: 300, // Tinggi minimal
                          maxHeight: MediaQuery.of(context).size.height *
                              0.6, // Tinggi maksimal 70% layar
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => buildSheet(),
                      );
                    },
                    icon: Icon(Icons.filter_list,
                        color: MyColor().customOrange, size: 20),
                    label: Text(
                      "Filter",
                      style: TextStyle(
                        color: MyColor().darkGrey,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: MyColor().secondaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6), // <== tambahkan ini

              Expanded(child: BlocBuilder<AHPResultBloc, AHPResultState>(
                builder: (context, state) {
                  if (state is AHPResultLoading) {
                    return Center(
                      child: const CustomLoading(
                        asset: 'assets/animations/loadingAnimation.json',
                      ),
                    );
                  } else if (state is AHPResultSuccess) {
                    return ListView.builder(
                      itemCount: state.ahpResult.length,
                      itemBuilder: (context, index) {
                        final item = state.ahpResult[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CampingCard(
                            imageUrl: item.campingSite.imageUrl,
                            title: item.campingSite.name,
                            location: item.campingSite.location,
                            rating: item.campingSite.rating,
                            reviews: item.campingSite.reviews,
                            isBookmarked: false,
                            onBookmarkPressed: () {},
                          ),
                        );
                      },
                    );
                  } else if (state is AHPResultError) {
                    return Center(
                      child: Text(
                        'Terjadi kesalahan: ${state.message}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 12,
                  );
                },
              )),
            ],
          ),
        ));
  }

  Widget buildSheet() => StatefulBuilder(builder: (context, setModalState) {
        List<int> ratingOptions = [1, 2, 3, 4, 5];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // Penting untuk menghindari overflow
            children: [
              // Header "Filter"
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.filter_alt_outlined),
                  SizedBox(width: 8),
                  Text('Filter', style: AppTextStyle.semiBold18),
                ],
              ),
              SizedBox(height: 16),

              // Konten utama (Rating + Lokasi) di dalam Expanded
              Expanded(
                child: SingleChildScrollView(
                  // Untuk konten yang panjang
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Rating
                      const Text(
                        "Rating",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: ratingOptions.map((rating) {
                          final isSelected = selectedRating == rating;
                          return ChoiceChip(
                            showCheckmark: false,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  rating.toString(),
                                  style: AppTextStyle.medium14.copyWith(
                                    color: isSelected
                                        ? myColor.customOrange
                                        : myColor.darkGrey,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.star,
                                  size: 18,
                                  color: isSelected
                                      ? myColor.customOrange
                                      : myColor.darkGrey.withOpacity(0.5),
                                ),
                              ],
                            ),
                            selected: isSelected,
                            onSelected: (_) =>
                                setModalState(() => selectedRating = rating),
                            selectedColor:
                                myColor.customOrange.withOpacity(0.1),
                            backgroundColor: Colors.transparent,
                            side: BorderSide(
                              color: isSelected
                                  ? myColor.customOrange
                                  : myColor.secondaryColor,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                          );
                        }).toList(),
                      ),

                      // Filter Lokasi
                      SizedBox(height: 16),
                      const Text(
                        "Lokasi",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: locations.map((location) {
                          final isSelected = selectedLocation == location;
                          return ChoiceChip(
                            showCheckmark: false,
                            label: Text(
                              location,
                              style: isSelected
                                  ? AppTextStyle.semiBold16
                                      .copyWith(color: myColor.primaryColor)
                                  : AppTextStyle.medium14
                                      .copyWith(color: myColor.darkGrey),
                            ),
                            selected: isSelected,
                            onSelected: (_) => setModalState(
                                () => selectedLocation = location),
                            selectedColor:
                                myColor.primaryColor.withOpacity(0.1),
                            backgroundColor: Colors.transparent,
                            side: BorderSide(
                              color: isSelected
                                  ? myColor.primaryColor
                                  : myColor.secondaryColor,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            labelPadding: EdgeInsets.symmetric(horizontal: 8),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // Tombol "Temukan Rekomendasi" (selalu di bawah)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CustomButton(
                  btnText: "Terapkan Filter",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      });
}
