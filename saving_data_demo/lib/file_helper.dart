import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileHelper {
  Future<String> get _path async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getFile(String fileName) async {
    final path = await _path;
    return File(p.join(path, fileName));
  }

  Future<File> writeToFile(String fileName, String data) async {
    final file = await getFile(fileName);
    return file.writeAsString(data);
  }

  Future<String> readFromFile(String fileName) async {
    try {
      final file = await getFile(fileName);
      return await file.readAsString();
    } catch (e) {
      print('Error reading from file: $e');
      return '';
    }
  }

  Future<void> deleteFile(String fileName) async {
    final file = await getFile(fileName);
    await file.delete();
  }
}
