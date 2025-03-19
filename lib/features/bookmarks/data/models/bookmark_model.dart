

import 'package:flutter_camping_frontend/features/bookmarks/domain/entities/bookmark.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';

class BookmarkModel extends Bookmark {
  BookmarkModel({
    required int id,
    required int userId,
    required int campingSiteId,
  }) : super(
          id: id,
          userId: userId,
          campingSite: campingSiteId,
        );

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'],
      userId: json['userId'],
      campingSiteId: (json['camping_site_id']),
    );
  }
}