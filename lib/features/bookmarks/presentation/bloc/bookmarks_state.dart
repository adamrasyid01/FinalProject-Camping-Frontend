part of 'bookmarks_bloc.dart';

abstract class BookmarksState extends Equatable {
  const BookmarksState();  

  @override
  List<Object> get props => [];
}
class BookmarksInitial extends BookmarksState {}
