class ApiEndpoints {
  // Menggunakan Hotspot
  // static const baseUrl = 'http://192.168.193.118:8000/api';

  // Menggunakana Wifi Rumah
  static const baseUrl = 'http://192.168.100.51:8000/api';

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
  static String campingSites(int id) => '$baseUrl/camping-locations/$id/sites';
}
