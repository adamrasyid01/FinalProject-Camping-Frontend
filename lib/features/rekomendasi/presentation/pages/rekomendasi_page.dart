import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_button.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_dialog.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_loading.dart';
import 'package:flutter_camping_frontend/core/widgets/empty_widget.dart';
import 'package:flutter_camping_frontend/features/bookmarks/presentation/bloc/bookmarks_bloc.dart';
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
  ScrollController controller = ScrollController();
  final MyColor myColor = MyColor();
  int selectedRating = 0;
  // Mengembalikan variabel selectedLocation karena digunakan di buildSheet versi asli
  String selectedLocation = "";
  int? selectedLocationId;
  final int _limit = 10;

  List<Map<String, dynamic>> locations = [
    {"id": 1, "name": "Kabupaten Bangkalan"},
    {"id": 2, "name": "Kabupaten Banyuwangi"},
    {"id": 3, "name": "Kabupaten Blitar"},
    {"id": 4, "name": "Kabupaten Bojonegoro"},
    {"id": 5, "name": "Kabupaten Bondowoso"},
    {"id": 6, "name": "Kabupaten Gresik"},
    {"id": 7, "name": "Kabupaten Jember"},
    {"id": 8, "name": "Kabupaten Jombang"},
    {"id": 9, "name": "Kabupaten Kediri"},
    {"id": 10, "name": "Kabupaten Lamongan"},
    {"id": 11, "name": "Kabupaten Lumajang"},
    {"id": 12, "name": "Kabupaten Madiun"},
    {"id": 13, "name": "Kabupaten Magetan"},
    {"id": 14, "name": "Kabupaten Malang"},
    {"id": 15, "name": "Kabupaten Mojokerto"},
    {"id": 16, "name": "Kabupaten Nganjuk"},
    {"id": 17, "name": "Kabupaten Ngawi"},
    {"id": 18, "name": "Kabupaten Pacitan"},
    {"id": 19, "name": "Kabupaten Pamekasan"},
    {"id": 20, "name": "Kabupaten Pasuruan"},
    {"id": 21, "name": "Kabupaten Ponorogo"},
    {"id": 22, "name": "Kabupaten Probolinggo"},
    {"id": 23, "name": "Kabupaten Sampang"},
    {"id": 24, "name": "Kabupaten Sidoarjo"},
    {"id": 25, "name": "Kabupaten Situbondo"},
    {"id": 26, "name": "Kabupaten Sumenep"},
    {"id": 27, "name": "Kabupaten Trenggalek"},
    {"id": 28, "name": "Kabupaten Tuban"},
    {"id": 29, "name": "Kabupaten Tulungagung"},
    {"id": 30, "name": "Kota Batu"},
    {"id": 31, "name": "Kota Blitar"},
    {"id": 32, "name": "Kota Kediri"},
    {"id": 33, "name": "Kota Madiun"},
    {"id": 34, "name": "Kota Malang"},
    {"id": 35, "name": "Kota Mojokerto"},
    {"id": 36, "name": "Kota Pasuruan"},
    {"id": 37, "name": "Kota Probolinggo"},
    {"id": 38, "name": "Kota Surabaya"},
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    controller.addListener(_onScroll);
  }

  void _loadInitialData() {
    context.read<AHPResultBloc>().add(AHPResultEventGetAHPResult(
          page: 1,
          limit: _limit,
        ));
  }

  void _loadMore() {
    final currentState = context.read<AHPResultBloc>().state;
    if (currentState is AHPResultSuccess && !currentState.hasReachedMax) {
      context.read<AHPResultBloc>().add(AHPResultEventGetAHPResult(
            page: currentState.currentPage + 1,
            limit: _limit,
            locationId: selectedLocationId,
            rating: selectedRating == 0 ? null : selectedRating,
          ));
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onScroll);
    controller.dispose();
    super.dispose();
  }

  void _toggleBookmark(int campingSiteId, bool isBookmarked) {
    final bookmarksBloc = context.read<BookmarksBloc>();
    if (isBookmarked) {
      bookmarksBloc.add(BookmarksEventDeleteBookmark(campingSiteId));
    } else {
      bookmarksBloc.add(BookmarksEventInsertBookmark(campingSiteId));
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      bookmarksBloc.add(BookmarksEventGetBookmarks());
    });
  }

  void _onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      _loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Rekomendasi", style: AppTextStyle.medium20),
        backgroundColor: Colors.white,
        elevation: 1.0,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: myColor.customOrange),
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
                iconBackgroundColor: myColor.customOrange,
              );
            },
          ),
        ],
      ),
      body: BlocListener<BookmarksBloc, BookmarksState>(
        listener: (context, state) {
          if (state is BookmarkInsertSuccess) {
            showCustomDialogAutoDismiss(
              context: context,
              title: 'Bookmark ditambahkan',
              content:
                  'Berhasil ditambahkan! Lihat di "Bookmark" untuk detailnya.',
              icon: Icons.check_circle,
              iconBackgroundColor: myColor.primaryColor,
            );
          } else if (state is BookmarkDeleteSuccess) {
            showCustomDialogAutoDismiss(
              context: context,
              title: 'Bookmark dihapus',
              content: 'Camping site berhasil dihapus dari bookmark kamu.',
              icon: Icons.delete,
              iconBackgroundColor: myColor.customRed,
            );
          }
        },
        child: BlocConsumer<AHPResultBloc, AHPResultState>(
          listener: (context, state) {
            if (state is AHPResultError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is AHPResultInitial ||
                (state is AHPResultLoading && state.ahpResults.isEmpty)) {
              return Center(
                child: CustomLoading(
                  asset: 'assets/animations/loadingAnimation.json',
                ),
              );
            }

            final ahpResults = state.ahpResults;
            final hasReachedMax =
                state is AHPResultSuccess ? state.hasReachedMax : false;

            // Menggunakan ListView sebagai parent utama agar seluruh halaman bisa di-scroll
            return ListView(
              controller: controller,
              padding: const EdgeInsets.all(16.0),
              children: [
                // 1. Banner Rekomendasi
                GestureDetector(
                  onTap: () async {
                    final result =
                        await context.pushNamed<bool>("prioritas_kriteria");
                    if (result == true && mounted) {
                      context
                          .read<AHPResultBloc>()
                          .add(AHPResultEventGetAHPResult());
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: MyColor().greenCustom,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SvgPicture.asset(
                            "assets/images/dapatkanRekomendasi.svg",
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Klik Disini",
                                    style: AppTextStyle.bold14
                                        .copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.touch_app_outlined,
                                      color: Colors.white, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Judul "Hasil Rekomendasi" dan Tombol Filter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hasil Rekomendasi", style: AppTextStyle.semiBold18),
                    ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.6,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) => buildSheet(),
                        );
                      },
                      icon: Icon(Icons.filter_list,
                          color: myColor.customOrange, size: 20),
                      label: Text("Filter",
                          style:
                              TextStyle(color: myColor.darkGrey, fontSize: 14)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: myColor.secondaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // 3. Konten Daftar Hasil
                if (ahpResults.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48.0),
                      child: EmptyCampingWidget(
                        message: 'Tidak ada hasil rekomendasi yang ditemukan.',
                      ),
                    ),
                  )
                else
                  // Menggunakan BlocBuilder untuk memastikan status bookmark selalu terbaru
                  BlocBuilder<BookmarksBloc, BookmarksState>(
                    builder: (context, bookmarksState) {
                      // Gunakan Column di sini karena parent-nya sudah ListView (scrollable)
                      return Column(
                        children: ahpResults.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final isBookmarked =
                              bookmarksState is BookmarksSuccess &&
                                  bookmarksState.bookmarkedSites.any(
                                      (site) => site.id == item.campingSite.id);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CampingCard(
                              key: ValueKey(item.campingSite.id),
                              imageUrl: item.campingSite.imageUrl,
                              title: item.campingSite.name,
                              location: item.campingSite.location,
                              rating: item.campingSite.rating,
                              reviews: item.campingSite.total_reviews,
                              isBookmarked: isBookmarked,
                              onBookmarkPressed: () => _toggleBookmark(
                                  item.camping_site_id, isBookmarked),
                              onDetailPressed: () async {
                                await context.pushNamed(
                                  'camping_site_detail',
                                  pathParameters: {
                                    'id':
                                        item.campingSite.locationId.toString(),
                                    'campingSiteId':
                                        item.campingSite.id.toString(),
                                  },
                                );
                              },
                              finalScore: item.final_score,
                              ranking: index + 1, // Ranking berdasarkan posisi
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),

                // 4. Indikator Loading untuk Pagination di paling bawah
                if (!hasReachedMax && ahpResults.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: CampingCardSkeleton(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // BAGIAN buildSheet() DIKEMBALIKAN KE VERSI ASLI ANDA
  // ==========================================================
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
                          final isSelected =
                              selectedLocationId == location['id'];

                          return ChoiceChip(
                            showCheckmark: false,
                            label: Text(
                              location['name'],
                              style: isSelected
                                  ? AppTextStyle.semiBold16
                                      .copyWith(color: myColor.primaryColor)
                                  : AppTextStyle.medium14
                                      .copyWith(color: myColor.darkGrey),
                            ),
                            selected: isSelected,
                            onSelected: (_) {
                              setModalState(() {
                                selectedLocationId = location['id'];
                                print(
                                    "Selected location id: $selectedLocationId");
                              });
                            },
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

              // Dua tombol di bagian bawah
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setModalState(() {
                            selectedRating = 0;
                            selectedLocation = "";
                            selectedLocationId = null;
                          });
                          // Dispatch event ke Bloc tanpa filter
                          context.read<AHPResultBloc>().add(
                                AHPResultEventGetAHPResult(),
                              );
                          context.pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: myColor.secondaryColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text(
                          "Reset",
                          style: AppTextStyle.semiBold16.copyWith(
                            color: myColor.darkGrey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        btnText: "Terapkan",
                        onPressed: () {
                          print("Kirim ke backend:");
                          print("Rating: $selectedRating");
                          print("Location ID: $selectedLocationId");

                          context.read<AHPResultBloc>().add(
                                AHPResultEventGetAHPResult(
                                  locationId: selectedLocationId,
                                  rating: selectedRating == 0
                                      ? null
                                      : selectedRating,
                                ),
                              );
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
