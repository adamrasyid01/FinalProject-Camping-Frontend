import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/bookmarks/data/datasources/bookmark_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/bookmarks/domain/repositories/bookmark_repository.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  final BookmarkRemoteDatasource bookmarkRemoteDatasource;

  BookmarkRepositoryImpl({required this.bookmarkRemoteDatasource});
  @override
  Future<Either<Failure, void>> insertBookmark(int campingSiteId) async {
    final result = await bookmarkRemoteDatasource.insertBookmark(campingSiteId);
    return Right(result);
  }

  @override
  Future<Either<Failure, List<CampingSite>>> getBookmarkedSites() async {
    try {
      final result = await bookmarkRemoteDatasource.getBookmarkedSites();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBookmark(int campingSiteId) async {
    final result = await bookmarkRemoteDatasource.deleteBookmark(campingSiteId);
    return Right(result);
  }
}
