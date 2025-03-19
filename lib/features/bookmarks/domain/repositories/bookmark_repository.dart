

import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/bookmarks/domain/entities/bookmark.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, List<CampingSite>>> getBookmarkedSites();
  Future<Either<Failure, void>> insertBookmark(int campingSiteId);
  Future<Either<Failure, void>> deleteBookmark(int campingSiteId);
}