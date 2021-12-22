import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil._() {
    alSpKeysToRemove = <String>[keySetPin];
  }

  final String keySetPin = 'setPin';

  late List<String> alSpKeysToRemove;

  static final SharedPreferencesUtil _instance = SharedPreferencesUtil._();

  static late SharedPreferences _storage;

  static Future<SharedPreferences> initialize() async {
    return _storage = await SharedPreferences.getInstance();
  }

  static SharedPreferencesUtil getInstance() => _instance;

  //sets
  Future<bool> setBool(String key, bool value) async =>
      _storage.setBool(key, value);

  Future<bool> setDouble(String key, double value) async =>
      _storage.setDouble(key, value);

  Future<bool> setInt(String key, int value) async =>
      _storage.setInt(key, value);

  Future<bool> setString(String key, String value) async =>
      _storage.setString(key, value);

  Future<bool> setStringList(String key, List<String> value) async =>
      _storage.setStringList(key, value);

  //gets
  bool? getBool(String key) => _storage.getBool(key);

  double? getDouble(String key) => _storage.getDouble(key);

  int? getInt(String key) => _storage.getInt(key);

  String? getString(String key) => _storage.getString(key);

  List<String>? getStringList(String key) => _storage.getStringList(key);

  //deletes..
  Future<bool> remove(String key) async => _storage.remove(key);

  Future<bool> clear() async => _storage.clear();
}

extension AlertTypeExtension on SharedPreferencesUtil {
  Future<bool> savePin(String pin) async => setString(keySetPin, pin);

  String get pin => getString(keySetPin) ?? '';

  bool get isPinSet => pin.isNotEmpty;

  bool verifyPin(String pin) => isPinSet && this.pin == pin;
}
