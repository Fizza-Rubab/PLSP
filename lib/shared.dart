import 'package:shared_preferences/shared_preferences.dart';


void sharedPrefInit() async {
    try {
        Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        prefs.getString("app_name");
    } catch (err) {
        Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        final SharedPreferences prefs = await _prefs;
        prefs.setString("app_name", "PLSP Lifesavers");
    }
}

dynamic putString(key, val) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var _res = prefs.setString("$key", val);
    return _res;
}

dynamic putBool(key, val) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var _res = prefs.setBool("$key", val);
    return _res;
}

dynamic getString(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? _res = prefs.getString("$key");
    return _res;
}

dynamic getBool(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    bool? _res = prefs.getBool("$key");
    return _res;
}

Future reset() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
}