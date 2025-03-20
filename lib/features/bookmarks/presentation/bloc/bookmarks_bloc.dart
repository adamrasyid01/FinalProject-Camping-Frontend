import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/features/bookmarks/domain/usecases/delete_bookmark.dart';
import 'package:flutter_camping_frontend/features/bookmarks/domain/usecases/get_bookmarked_sites.dart';
import 'package:flutter_camping_frontend/features/bookmarks/domain/usecases/insert_bookmark.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  final GetBookmarkedSites getBookmarkedSites;
  final InsertBookmark insertBookmark;
  final DeleteBookmark deleteBookmark;
  BookmarksBloc(
      {required this.getBookmarkedSites,
      required this.insertBookmark,
      required this.deleteBookmark})
      : super(BookmarksInitial()) {
    on<BookmarksEventGetBookmarks>((event, emit) async {
      final result = await getBookmarkedSites.execute();
      result.fold(
        (failure) => emit(BookmarkError(failure.message)),
        (bookmarks) => emit(BookmarksSuccess(bookmarks)),
      );
    });

    on<BookmarksEventInsertBookmark>((event, emit) async {
      // emit(BookmarksLoading());
      final result = await insertBookmark.execute(event.campingSiteId);
      result.fold(
        (failure) => emit(BookmarkError(failure.message)),
        (bookmarks) => emit(BookmarkInsertSuccess()),
      );
    });

    on<BookmarksEventDeleteBookmark>((event, emit) async {
      // emit(BookmarksLoading());
      final result = await deleteBookmark.call(event.campingSiteId);
      result.fold(
        (failure) => emit(BookmarkError(failure.message)),
        (bookmarks) => emit(BookmarkDeleteSuccess()),
      );
    });
  }
}
