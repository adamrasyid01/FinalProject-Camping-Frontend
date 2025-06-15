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
  String? _campingLocationName;

  final SaveNameCampLocation saveNameCampLocation = SaveNameCampLocation();
  ScrollController controller = ScrollController();
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _loadCampLocationName();
    _loadInitialData();
    controller.addListener(_onScroll);
  }

  void _loadCampLocationName() async {
    final name = await saveNameCampLocation.getCampLocationName();
    if (mounted) {
      setState(() {
        _campingLocationName = name;
      });
    }
  }

  void _loadInitialData() {
    context.read<HomeBloc>().add(HomeEventGetCampingSite(
          locationId: widget.locationId,
          limit: _limit,
        ));
    context.read<BookmarksBloc>().add(BookmarksEventGetBookmarks());
  }

  void _loadMore() {
    final currentState = context.read<HomeBloc>().state;
    if (currentState is HomeStateSuccessSites && !currentState.hasReachedMax) {
      context.read<HomeBloc>().add(
            HomeEventGetCampingSite(
              locationId: widget.locationId,
              page: currentState.currentPage + 1,
              limit: _limit,
            ),
          );
    }
  }

  // void _fetchCampingLocationSites() {
  //   context.read<HomeBloc>().add(
  //         HomeEventGetCampingSite(locationId: widget.locationId),
  //       );
  //   context.read<BookmarksBloc>().add(BookmarksEventGetBookmarks());
  // }

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
    final MyColor myColor = MyColor();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _campingLocationName ?? '',
          style: AppTextStyle.medium20,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pushNamed('/home'),
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
      body: BlocConsumer<BookmarksBloc, BookmarksState>(
        listener: (context, state) async {
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
              title: 'Bookmark dihapus...',
              content: 'Camping site berhasil dihapus dari bookmark kamu.',
              icon: Icons.delete,
              iconBackgroundColor: myColor.customRed,
            );
          }
        },
        builder: (context, bookmarksState) {
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeStateInitial ||
                  (state is HomeStateLoading && state.campingSites.isEmpty)) {
                return const CustomLoading(
                  asset: 'assets/animations/loadingAnimation.json',
                );
              }
              final campingData = state.campingSites;
              final hasReachedMax =
                  state is HomeStateSuccessSites ? state.hasReachedMax : false;

              if (campingData.isEmpty) {
                return Center(
                  child: EmptyCampingWidget(
                    message: 'Tidak ada hasil rekomendasi yang ditemukan.',
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    SearchInput(
                      controller: _searchController,
                      hintText: "Cari tempat camping",
                      onSearchTap: () {
                        final searchValue = _searchController.text.trim();
                        context.read<HomeBloc>().add(
                              HomeEventGetCampingSite(
                                locationId: widget.locationId,
                                search:
                                    searchValue.isNotEmpty ? searchValue : null,
                                page: 1,
                                limit: _limit,
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: myColor.customOrange,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Klik pada kotak camping untuk membuka link pada aplikasi atau website Google Maps",
                        style: AppTextStyle.regular12.copyWith(
                          color: myColor.customOrange,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: hasReachedMax
                            ? campingData.length
                            : campingData.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= campingData.length) {
                            return hasReachedMax
                                ? SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: MyColor().customOrange,
                                      ),
                                    ),
                                  );
                          }
                          final site = campingData[index];
                          final isBookmarked =
                              bookmarksState is BookmarksSuccess &&
                                  bookmarksState.bookmarkedSites.contains(site);

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
                              onBookmarkPressed: () {
                                _toggleBookmark(site.id, isBookmarked);
                              },
                              onDetailPressed: () {
                                context.pushNamed(
                                  'camping_site_detail',
                                  pathParameters: {
                                    'id': widget.locationId.toString(),
                                    'campingSiteId': site.id.toString(),
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
