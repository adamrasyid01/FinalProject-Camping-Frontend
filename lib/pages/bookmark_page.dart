import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/features/bloc/bookmark_bloc.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookmarkError) {
            return Center(child: Text(state.message));
          } else if (state is BookmarkSuccess) {
            final bookmarkedSites = state.bookmarkedSites;

            return ListView.builder(
              itemCount: bookmarkedSites.length,
              itemBuilder: (context, index) {
                final site = bookmarkedSites[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<BookmarkBloc, BookmarkState>(
                    builder: (context, state) {
                      return CampingCard(
                        imageUrl: site.imageUrl,
                        title: site.name,
                        location: site.location,
                        rating: site.rating,
                        reviews: site.reviews,
                        isBookmarked: true,
                        onBookmarkPressed: () {
                          context
                              .read<BookmarkBloc>()
                              .add(BookmarkEventToggle(site));
                        },
                      );
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text("Tidak ada bookmark."));
        },
      ),
    );
  }
}
