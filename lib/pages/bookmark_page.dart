import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/features/bookmarks/presentation/bloc/bookmarks_bloc.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    // Memanggil event untuk mendapatkan daftar bookmark
    context.read<BookmarksBloc>().add(BookmarksEventGetBookmarks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: BlocListener<BookmarksBloc, BookmarksState>(
        listener: (context, state) {
          if (state is BookmarkDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Bookmark deleted"),
                duration: Duration(seconds: 2), // Durasi lebih singkat
              ),
            );
            context.read<BookmarksBloc>().add(BookmarksEventGetBookmarks());
          }
        },
        child: BlocBuilder<BookmarksBloc, BookmarksState>(
          builder: (context, state) {
            if (state is BookmarksLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookmarkError) {
              return Center(child: Text(state.message));
            } else if (state is BookmarksSuccess) {
              final bookmarkedSites = state.bookmarkedSites;
              if (bookmarkedSites.isEmpty) {
                return const Center(child: Text("Tidak ada bookmark."));
              }

              return ListView.builder(
                itemCount: bookmarkedSites.length,
                itemBuilder: (context, index) {
                  final site = bookmarkedSites[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CampingCard(
                      imageUrl: site.imageUrl,
                      title: site.name,
                      location: site.location,
                      rating: site.rating,
                      reviews: site.reviews,
                      isBookmarked: true,
                      onBookmarkPressed: () {
                        context
                            .read<BookmarksBloc>()
                            .add(BookmarksEventDeleteBookmark(site.id));
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("Tidak ada bookmark."));
          },
        ),
      ),
    );
  }
}
