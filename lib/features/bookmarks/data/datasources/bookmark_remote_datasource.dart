import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';

abstract class BookmarkRemoteDatasource {
  Future<List<CampingSiteModel>> getBookmarkedSites();
  Future<void> insertBookmark(int campingSiteId);
}

class BookmarkRemoteDatasourceImpl implements BookmarkRemoteDatasource {
  final DioClient dio;

  BookmarkRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<CampingSiteModel>> getBookmarkedSites() async {
    try {
      final response = await dio.getRequest(ApiEndpoints.bookmarks);
      List<dynamic> data = response.data;
      return CampingSiteModel.fromJsonList(data)
          .whereType<CampingSiteModel>()
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> insertBookmark(int campingSiteId) async {
    try {
      await dio.postRequest(ApiEndpoints.bookmarks,
          data: {"camping_site_id": campingSiteId});
    } catch (e) {
      // Handle the error appropriately, e.g., log it or rethrow it
      throw ServerFailure("Failed to insert bookmark");
    }
  }
}
