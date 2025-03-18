part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkError extends BookmarkState {
  final String message;

  const BookmarkError(this.message);

  @override
  List<Object> get props => [message];
}

class BookmarkSuccess extends BookmarkState {
  final List<CampingSite> bookmarkedSites;

  const BookmarkSuccess(this.bookmarkedSites);

  @override
  List<Object> get props => [bookmarkedSites];
}
