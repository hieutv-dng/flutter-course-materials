import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static const String _listNameKey = '_listNameKey';
  static const String _caloriesKey = '_caloriesKey';
  static const String _showFileSizeKey = '_showFileSizeKey';

  SPHelper._internal();
  static final SPHelper _instance = SPHelper._internal();
  late SharedPreferences _preferences;

  static Future<SPHelper> getInstance() async {
    _instance._preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  Future<bool> setListName(String listName) async {
    return await _preferences.setString(_listNameKey, listName);
  }

  String getListName() {
    return _preferences.getString(_listNameKey) ?? 'Unknow';
  }

  Future<bool> setCalories(int calories) async {
    return await _preferences.setInt(_caloriesKey, calories);
  }

  int getCalories() {
    return _preferences.getInt(_caloriesKey) ?? 0;
  }

  Future<bool> setShowFileSize(bool showFileSize) async {
    return await _preferences.setBool(_showFileSizeKey, showFileSize);
  }

  bool getShowFileSize() {
    return _preferences.getBool(_showFileSizeKey) ?? false;
  }
}
