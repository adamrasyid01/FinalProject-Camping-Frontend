import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/bookmarks/domain/repositories/bookmark_repository.dart';

class InsertBookmark {
  final BookmarkRepository bookmarksRepository;

  InsertBookmark({required this.bookmarksRepository});

  Future<Either<Failure, void>> execute(int campingSiteId) async {
    return await bookmarksRepository.insertBookmark(campingSiteId);
  }
}
