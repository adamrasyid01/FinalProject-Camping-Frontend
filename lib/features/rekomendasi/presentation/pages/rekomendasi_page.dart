import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_loading.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_bloc.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_event.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/bloc/ahp_result_state.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/presentation/pages/prioritas_kriteria_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RekomendasiPage extends StatefulWidget {
  const RekomendasiPage({super.key});

  @override
  State<RekomendasiPage> createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
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
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (BuildContext context) {
                          return const Text(
                            "Terapkan Filter",
                            style: TextStyle(fontSize: 16),
                          );
                        },
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
}
