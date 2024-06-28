import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureHelper {
  static const String _listNameKey = '_listNameKey';
  static const String _caloriesKey = '_caloriesKey';
  static const String _showFileSizeKey = '_showFileSizeKey';

  SecureHelper._internal();
  static final SecureHelper _instance = SecureHelper._internal();
  final _storage = const FlutterSecureStorage();

  static Future<SecureHelper> getInstance() async {
    return _instance;
  }

  Future<void> setListName(String listName) async {
    await _storage.write(key: _listNameKey, value: listName);
  }

  Future<String> getListName() async {
    return await _storage.read(key: _listNameKey) ?? 'Unknow';
  }

  Future<void> setCalories(int calories) async {
    await _storage.write(key: _caloriesKey, value: calories.toString());
  }

  Future<int> getCalories() async {
    final calories = await _storage.read(key: _caloriesKey);
    return calories != null ? int.parse(calories) : 0;
  }

  Future<void> setShowFileSize(bool showFileSize) async {
    await _storage.write(key: _showFileSizeKey, value: showFileSize.toString());
  }

  Future<bool> getShowFileSize() async {
    final showFileSize = await _storage.read(key: _showFileSizeKey);
    return bool.tryParse(showFileSize ?? 'true') ?? false;
  }
}
