import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camping_frontend/core/constants/color.dart';
import 'package:flutter_camping_frontend/core/constants/text_styles.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_dialog.dart';
import 'package:flutter_camping_frontend/core/widgets/custom_list_sites.dart';
import 'package:flutter_camping_frontend/core/widgets/empty_widget.dart';
import 'package:flutter_camping_frontend/features/bookmarks/presentation/bloc/bookmarks_bloc.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final MyColor myColor = MyColor();
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
        title: Text(
          "Bookmarks",
          style: AppTextStyle.medium20,
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5), // Ketebalan garis
          child: Divider(
            height: 1,
            thickness: 1,
            color: myColor.secondaryColor, // Warna garis
          ),
        ),
      ),
      body: BlocListener<BookmarksBloc, BookmarksState>(
        listener: (context, state) {
          if (state is BookmarkDeleteSuccess) {
            showCustomDialogAutoDismiss(
              context: context,
              title: 'Bookmark dihapus...',
              content: 'Camping site berhasil dihapus dari bookmark kamu.',
              icon: Icons.delete,
              iconBackgroundColor: myColor.customRed,
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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0),
                  child: EmptyCampingWidget(
                    message:
                        "Anda masih belum memiliki tempat camping yang tersimpan.",
                  ),
                );
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
                      reviews: site.total_reviews,
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
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
