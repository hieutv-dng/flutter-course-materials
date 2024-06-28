import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saving_data_demo/db/client.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._internal();

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'my_db.db');
    return openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future _onCreate(Database db, int version) async {
    final Batch batch = db.batch();
    batch.execute('CREATE TABLE Client ('
        'id INTEGER PRIMARY KEY,'
        'first_name TEXT,'
        'last_name TEXT'
        ')');
    await batch.commit(noResult: true);
  }

  static Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      final Batch batch = db.batch();
      batch.execute('DROP TABLE IF EXISTS Client');
      await batch.commit(noResult: true);
      await _onCreate(db, newVersion);
    }
  }

  static Future<int> newClient(Client newClient) async {
    final db = await database;
    //get the biggest id in the table
    final table = await db.rawQuery('SELECT MAX(id)+1 as id FROM Client');
    final newId = table.first['id'];
    //insert to the table using the new id
    final res = await db.rawInsert(
        'INSERT INTO Client (id, first_name, last_name) VALUES (?, ?, ?)',
        [newId, newClient.firstName, newClient.lastName]);
    return res;
  }

  static Future<Client?> getClient(int id) async {
    final db = await database;
    final res = await db.query('Client', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Client.fromJson(res.first) : null;
  }

  static Future<List<Client>> getClients() async {
    final db = await database;
    final res = await db.query('Client');
    return res.isNotEmpty ? res.map((c) => Client.fromJson(c)).toList() : [];
  }

  static Future<int> updateClient(Client newClient) async {
    final db = await database;
    final res = await db.update('Client', newClient.toJson(),
        where: 'id = ?', whereArgs: [newClient.id]);
    return res;
  }

  static Future<int> deleteClient(int id) async {
    final db = await database;
    final res = await db.delete('Client', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
