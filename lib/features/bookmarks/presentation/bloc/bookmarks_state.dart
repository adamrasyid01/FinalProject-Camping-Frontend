part of 'bookmarks_bloc.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();  

  @override
  List<Object> get props => [];
}


class BookmarksInitial extends BookmarksState {}

class BookmarksLoading extends BookmarksState {}

class BookmarkError extends BookmarksState {
  final String message;

  const BookmarkError(this.message);

  @override
  List<Object> get props => [message];
}

class BookmarksSuccess extends BookmarksState {
  final List<CampingSite> bookmarkedSites;

  const BookmarksSuccess(this.bookmarkedSites);

  @override
  List<Object> get props => [bookmarkedSites];
}

class BookmarkInsertSuccess extends BookmarksState {
  @override
  List<Object> get props => [];
}

class BookmarkDeleteSuccess extends BookmarksState {
  @override
  List<Object> get props => [];
}