import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // Base URL diambil dari .env
  static String get baseUrl => dotenv.get('BASE_URL');

  // Auth Endpoints
  static String get login => '$baseUrl/login';
  static String get register => '$baseUrl/register';
  static String get logout => '$baseUrl/logout';
  static String get currentUser => '$baseUrl/user';

  // Camping Locations Endpoints
  static String campingLocations({String? filter}) {
    String url = '$baseUrl/home';
    if (filter != null && filter.isNotEmpty && filter != 'semua') {
      url += '?filter=$filter';
    }
    return url;
  }

  // User Preference Criteria Endpoints
  static String get userPreferenceCriteria =>
      '$baseUrl/user-preference-criteria';

  // Camping Sites Endpoints
  static String campingSites(int id, {String? search}) {
    String url = '$baseUrl/camping-locations/$id/sites';
    if (search != null && search.isNotEmpty) {
      url += '?search=$search';
    }
    return url;
  }

  // Bookmark Endpoint
  static String get bookmarks => '$baseUrl/bookmarks';
  static String deleteBookmark(int campingSiteId) =>
      '$baseUrl/bookmarks/$campingSiteId';

  // AHP Result Endpoint dengan query parameters dan baseUrl
  static String ahpResults({
    int? locationId,
    int? rating,
    int page = 1,
    int limit = 10,
  }) {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      if (locationId != null) 'location_id': locationId.toString(),
      if (rating != null) 'min_rating': rating.toString(),
    };

    final queryString = Uri(queryParameters: queryParams).query;
    return '$baseUrl/ahp-results?$queryString';
  }
}
