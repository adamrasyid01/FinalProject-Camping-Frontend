import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/bookmarks/domain/repositories/bookmark_repository.dart';

class DeleteBookmark {
  final BookmarkRepository bookmarkRepository;

  DeleteBookmark({required this.bookmarkRepository});

  Future<Either<Failure, void>> call(int campingSiteId) async {
    return await bookmarkRepository.deleteBookmark(campingSiteId);
  }
}
