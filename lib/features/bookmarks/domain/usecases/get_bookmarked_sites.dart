import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

class GetBookmarkedSites {
  final BookmarkRepository bookmarksRepository;

  GetBookmarkedSites({required this.bookmarksRepository});

  Future<Either<Failure, List<CampingSite>>> execute() async {
    return await bookmarksRepository.getBookmarkedSites();
  }
}
