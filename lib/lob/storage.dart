import 'package:stated/stated.dart';
import 'package:shared_preferences/shared_preferences.dart' as shared;

class Storage with AsyncInit {
  late shared.SharedPreferences _storage;

  String? get(String key) {
    return _storage.getString(key);
  }

  void set<T>(String key, String? value) {
    if (value == null) {
      _storage.remove(key);
    } else {
      _storage.setString(key, value);
    }
  }

  @override
  Future<void> init() async {
    _storage = await shared.SharedPreferences.getInstance();
  }
}
