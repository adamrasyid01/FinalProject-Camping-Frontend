import 'package:flutter_camping_frontend/features/bookmarks/domain/entities/bookmark.dart';

class BookmarkModel extends Bookmark {
  const BookmarkModel({
    required super.id,
    required super.userId,
    required int campingSiteId,
  }) : super(
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
