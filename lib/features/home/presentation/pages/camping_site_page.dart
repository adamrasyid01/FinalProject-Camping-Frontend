import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/services/save_name_camp_location.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
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
  final String _campingLocationName = "Loading...";
  final SaveNameCampLocation saveNameCampLocation = SaveNameCampLocation();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchCampingLocationSites();
  }

  void _fetchCampingLocationSites() {
    context.read<HomeBloc>().add(
          HomeEventGetCampingSite(locationId: widget.locationId),
        );
    context.read<BookmarksBloc>().add(BookmarksEventGetBookmarks());
  }

  void _toggleBookmark(int campingSiteId, bool isBookmarked) {
    final bookmarksBloc = context.read<BookmarksBloc>();

    if (isBookmarked) {
      bookmarksBloc.add(BookmarksEventDeleteBookmark(campingSiteId));
    } else {
      bookmarksBloc.add(BookmarksEventInsertBookmark(campingSiteId));
    }

    // Setelah proses selesai, perbarui daftar bookmark
    Future.delayed(const Duration(milliseconds: 300), () {
      bookmarksBloc.add(BookmarksEventGetBookmarks());
    });
  }

  @override
  Widget build(BuildContext context) {
    final MyColor myColor = MyColor();
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeStateSuccessCampingSite) {
              return FutureBuilder<String?>(
                future: saveNameCampLocation.getCampLocationName(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? _campingLocationName,
                    style: AppTextStyle.medium20,
                  );
                },
              );
            }
            return Text(_campingLocationName, style: AppTextStyle.medium20);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/home'),
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Bookmark added"),
                duration: Duration(seconds: 1),
              ),
            );
          } else if (state is BookmarkDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Bookmark deleted"),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, bookmarksState) {
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeStateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeStateError) {
                return Center(child: Text(state.message));
              } else if (state is HomeStateSuccessCampingSite) {
                final campingData = state.campingSite;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SearchInput(
                          controller: _searchController,
                          hintText: "Cari tempat camping",
                          onChanged: (value) {
                            // print('🔍 Search Value: $value');

                            _debounce?.cancel();
                            _debounce =
                                Timer(const Duration(milliseconds: 500), () {
                              context.read<HomeBloc>().add(
                                    HomeEventGetCampingSite(
                                      locationId: widget.locationId,
                                      search: value.isNotEmpty ? value : null,
                                    ),
                                  );
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // Warna latar belakang
                            borderRadius: BorderRadius.circular(
                                20), // Border radius sesuai gambar
                            border: Border.all(
                              color: myColor.customOrange, // Warna border
                              width: 1, // Ketebalan border
                            ),
                          ),
                          child: Text(
                            "Klik pada kotak camping untuk membuka link pada aplikasi atau website Google Maps",
                            style: AppTextStyle.regular12.copyWith(
                              color:
                                  myColor.customOrange, // Warna teks deskripsi
                            ),
                          ),
                        ),
                      ),
                      if (campingData.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: EmptyCampingWidget(
                              message: "Data tidak ditemukan"),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: campingData.length,
                            itemBuilder: (context, index) {
                              final site = campingData[index];

                              final isBookmarked = bookmarksState
                                      is BookmarksSuccess &&
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
                                  reviews: site.reviews,
                                  isBookmarked: isBookmarked,
                                  onBookmarkPressed: () {
                                    _toggleBookmark(site.id, isBookmarked);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                );
              }
              return const Center(child: Text("Data tidak ditemukan"));
            },
          );
        },
      ),
    );
  }
}
