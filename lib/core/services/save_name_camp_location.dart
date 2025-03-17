import 'package:shared_preferences/shared_preferences.dart';



class SaveNameCampLocation {
  // Simpan ke sharedPreference
  static const String _campLocationName = 'campLocation';
  Future<void> saveCampLocationName(String campLocation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_campLocationName, campLocation);
  }

  // Hapus dari sharedPreference
  Future<void> removeCampLocationName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_campLocationName);
  }

  // Ambil dari sharedPreference
  Future<String?> getCampLocationName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_campLocationName);
  }
}
