class ApiEndpoints {
  static const baseUrl = 'http://192.168.100.51:8000/api';

  // Auth Endpoints
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String logout = '$baseUrl/logout';
  static const String currentUser = '$baseUrl/user';

  // Camping Locations Endpoints
  static const String campingLocations = '$baseUrl/home';
}
