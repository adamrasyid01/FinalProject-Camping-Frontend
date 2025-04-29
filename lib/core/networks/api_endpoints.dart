class ApiEndpoints {
  // Menggunakan Hotspot
  // static const baseUrl = 'http://192.168.19.118:8000/api';

  // Menggunakana Wifi Rumah
  static const baseUrl = 'http://192.168.100.51:8000/api';

  // static const baseUrl = 'http://10.252.134.8:8000/api';

  // Auth Endpoints
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String logout = '$baseUrl/logout';
  static const String currentUser = '$baseUrl/user';

  // Camping Locations Endpoints
  static const String campingLocations = '$baseUrl/home';

  // User Preference Criteria Endpoints
  static const String userPreferenceCriteria =
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
  static const String bookmarks = '$baseUrl/bookmarks';
  static String deleteBookmark(int campingSiteId) =>
      '$baseUrl/bookmarks/$campingSiteId';

   // AHP Result Endpoint dengan query parameters
  static String ahpResults({int? locationId, int? rating}) {
    String url = '$baseUrl/ahp-results';
    final params = <String>[];
    
    if (locationId != null && locationId > 0) {
      params.add('location_id=$locationId');
    }
    
    if (rating != null) {
      params.add('min_rating=$rating');
    }
    
  if (params.isNotEmpty) {
      url += '?${params.join('&')}';
    }
    
    return url;
  }
}
