part of 'bookmarks_bloc.dart';

abstract class BookmarksEvent extends Equatable {
  const BookmarksEvent();

  @override
  List<Object> get props => [];
}

class BookmarksEventGetBookmarks extends BookmarksEvent {
  const BookmarksEventGetBookmarks();

  @override
  List<Object> get props => [];
}

class BookmarksEventInsertBookmark extends BookmarksEvent {
  final int campingSiteId;

  const BookmarksEventInsertBookmark(this.campingSiteId);

  @override
  List<Object> get props => [campingSiteId];
}

class BookmarksEventDeleteBookmark extends BookmarksEvent {
  final int campingSiteId;

  const BookmarksEventDeleteBookmark(this.campingSiteId);

  @override
  List<Object> get props => [campingSiteId];
}