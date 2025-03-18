part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class BookmarkEventToggle extends BookmarkEvent {
  final CampingSite campingSite;

  const BookmarkEventToggle(this.campingSite);

  @override
  List<Object> get props => [campingSite];
}

class BookmarkEventGetBookmarks extends BookmarkEvent {}
