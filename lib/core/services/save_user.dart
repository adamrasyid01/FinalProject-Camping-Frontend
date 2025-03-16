import 'package:shared_preferences/shared_preferences.dart';

class SaveUser {
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';

  /// 🔹 Simpan username ke SharedPreferences
  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    print("✅ Username disimpan: $username");
}

  /// 🔹 Simpan email ke SharedPreferences
  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  /// 🔹 Ambil username dari SharedPreferences
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('username');
    print("🔍 Mengambil username: $user"); // Debugging
    return user;
  }

  /// 🔹 Ambil email dari SharedPreferences
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
}
