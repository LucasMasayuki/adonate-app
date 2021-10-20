import 'package:clean_architeture_flutter/app/data/cache/delete_shared_preferences.dart';
import 'package:clean_architeture_flutter/app/data/cache/fetch_shared_preferences.dart';
import 'package:clean_architeture_flutter/app/data/cache/save_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAdapter
    implements
        SaveSharedPreferences,
        FetchSharedPreferences,
        DeleteSharedPreferences {
  SharedPreferences? preferences;

  SharedPreferencesAdapter({this.preferences});

  Future<SharedPreferences?> _getInstance() async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }

    return preferences;
  }

  Future<void> save({required String key, required String value}) async {
    await _getInstance();
    await preferences!.setString(key, value);
  }

  Future<String?> fetch(String key) async {
    await _getInstance();

    return preferences!.getString(key);
  }

  Future<void> delete(String key) async {
    await _getInstance();
    await preferences!.remove(key);
  }
}
