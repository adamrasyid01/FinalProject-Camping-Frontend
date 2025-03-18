import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  List<CampingSite> _bookmarkedSites = [];

  BookmarkBloc() : super(BookmarkInitial()) {
    on<BookmarkEventToggle>((event, emit) {
      // Periksa apakah item sudah ada dalam daftar bookmark
      if (_bookmarkedSites.contains(event.campingSite)) {
        _bookmarkedSites.remove(event.campingSite);
      } else {
        _bookmarkedSites.add(event.campingSite);
      }

      emit(BookmarkSuccess(List.from(_bookmarkedSites)));
    });

    on<BookmarkEventGetBookmarks>((event, emit) {
      emit(BookmarkSuccess(List.from(_bookmarkedSites)));
    });
  }
}
