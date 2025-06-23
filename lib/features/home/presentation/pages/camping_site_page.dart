import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/services/save_name_camp_location.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_dialog.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_loading.dart';
import 'package:flutter_camping_frontend/core/widgets/empty_widget.dart';
import 'package:flutter_camping_frontend/features/bookmarks/presentation/bloc/bookmarks_bloc.dart';
import 'package:flutter_camping_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_camping_frontend/core/widgets/search_input.dart';

class CampingSitePage extends StatefulWidget {
  final int locationId;
  const CampingSitePage({super.key, required this.locationId});

  @override
  State<CampingSitePage> createState() => _CampingSitePageState();
}

class _CampingSitePageState extends State<CampingSitePage> {
  final TextEditingController _searchController = TextEditingController();
  final SaveNameCampLocation saveNameCampLocation = SaveNameCampLocation();
  final ScrollController _scrollController = ScrollController();
  final int _limit = 10;

  String? _campingLocationName;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // PENTING: Dispose semua controller untuk menghindari memory leaks
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    _loadCampLocationName();
    // Memuat ulang data site dari halaman pertama
    context.read<HomeBloc>().add(HomeEventGetCampingSite(
          locationId: widget.locationId,
          limit: _limit,
          page: 1, // Selalu mulai dari halaman 1 saat refresh
        ));
    // Memuat ulang data bookmark
    context.read<BookmarksBloc>().add(BookmarksEventGetBookmarks());
  }

  void _loadCampLocationName() async {
    final name = await saveNameCampLocation.getCampLocationName();
    if (mounted) {
      setState(() {
        _campingLocationName = name;
      });
    }
  }

  void _onSearch() {
    final searchValue = _searchController.text.trim();
    context.read<HomeBloc>().add(
          HomeEventGetCampingSite(
            locationId: widget.locationId,
            search: searchValue.isNotEmpty ? searchValue : null,
            page:
                1, // Selalu mulai dari halaman 1 saat melakukan pencarian baru
            limit: _limit,
          ),
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Trigger load more saat mendekati akhir list
      _loadMore();
    }
  }

  void _loadMore() {
    final currentState = context.read<HomeBloc>().state;
    // Pastikan state adalah HomeStateSuccessSites dan tidak sedang dalam proses loading lebih banyak
    if (currentState is HomeStateSuccessSites && !currentState.hasReachedMax) {
      context.read<HomeBloc>().add(
            HomeEventGetCampingSite(
              locationId: widget.locationId,
              page: currentState.currentPage + 1,
              limit: _limit,
              search: _searchController.text.trim().isNotEmpty
                  ? _searchController.text.trim()
                  : null,
            ),
          );
    }
  }

  void _toggleBookmark(int campingSiteId, bool isBookmarked) {
    // Cukup dispatch event, biarkan BLoC yang bekerja.
    // Tidak perlu refresh manual dengan `Future.delayed` lagi.
    if (isBookmarked) {
      context
          .read<BookmarksBloc>()
          .add(BookmarksEventDeleteBookmark(campingSiteId));
    } else {
      context
          .read<BookmarksBloc>()
          .add(BookmarksEventInsertBookmark(campingSiteId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final MyColor myColor = MyColor();
    return GestureDetector(
      onTap: () {
        // 2. Saat area di luar TextField diklik, hilangkan fokus
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_campingLocationName ?? 'Daftar Camp',
              style: AppTextStyle.medium20),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Divider(
              height: 1,
              thickness: 1,
              color: MyColor().secondaryColor,
            ),
          ),
        ),
        body: BlocListener<BookmarksBloc, BookmarksState>(
          // Menggunakan BlocListener di sini untuk menangani side-effect seperti dialog dan refresh
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
              // REFRESH data bookmark setelah berhasil
              context.read<BookmarksBloc>().add(BookmarksEventGetBookmarks());
            } else if (state is BookmarkDeleteSuccess) {
              showCustomDialogAutoDismiss(
                context: context,
                title: 'Bookmark dihapus',
                content: 'Camping site berhasil dihapus dari bookmark kamu.',
                icon: Icons.delete,
                iconBackgroundColor: myColor.customRed,
              );
              // REFRESH data bookmark setelah berhasil
              context.read<BookmarksBloc>().add(BookmarksEventGetBookmarks());
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                SearchInput(
                  controller: _searchController,
                  hintText: "Cari tempat camping",
                  onSearchTap: _onSearch,
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: myColor.customOrange, // Warna latar solid
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: myColor.customOrange.withOpacity(0.3),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    "Klik pada kartu camping untuk melihat detail dan rute Google Maps.",
                    style: AppTextStyle.semiBold16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, homeState) {
                      if (homeState is HomeStateInitial ||
                          (homeState is HomeStateLoading &&
                              homeState.campingSites.isEmpty)) {
                        return const CustomLoading(
                            asset: 'assets/animations/loadingAnimation.json');
                      }

                      if (homeState is HomeStateError) {
                        return Center(child: Text(homeState.message));
                      }

                      if (homeState.campingSites.isEmpty) {
                        return const Center(
                            child: EmptyCampingWidget(
                                message:
                                    'Tidak ada camping site yang ditemukan.'));
                      }

                      final campingData = homeState.campingSites;
                      final hasReachedMax = homeState is HomeStateSuccessSites
                          ? homeState.hasReachedMax
                          : false;

                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: hasReachedMax
                            ? campingData.length
                            : campingData.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= campingData.length) {
                            // Ini adalah item loading di bagian bawah list
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: CampingCardSkeleton(),
                            );
                          }

                          final site = campingData[index];
                          return BlocBuilder<BookmarksBloc, BookmarksState>(
                            builder: (context, bookmarksState) {
                              final isBookmarked =
                                  bookmarksState is BookmarksSuccess &&
                                      bookmarksState.bookmarkedSites.any(
                                          (bookmark) => bookmark.id == site.id);

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: CampingCard(
                                  key: ValueKey(site.id),
                                  imageUrl: site.imageUrl,
                                  title: site.name,
                                  location:
                                      '${site.location}, Jawa Timur, Indonesia',
                                  rating: site.rating,
                                  reviews: site.total_reviews,
                                  isBookmarked: isBookmarked,
                                  onBookmarkPressed: () =>
                                      _toggleBookmark(site.id, isBookmarked),
                                  onDetailPressed: () async {
                                    // PERBAIKAN UTAMA: Tambahkan async dan await
                                    await context.pushNamed(
                                      'camping_site_detail',
                                      pathParameters: {
                                        'id': widget.locationId.toString(),
                                        'campingSiteId': site.id.toString(),
                                      },
                                    );
                                    // Setelah kembali, panggil method ini untuk refresh data
                                    print(
                                        "Kembali ke daftar site, memuat ulang data...");
                                    _loadInitialData();
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
