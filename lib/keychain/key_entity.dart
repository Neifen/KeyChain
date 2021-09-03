import 'package:key_chain/app_constrains/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class KeyEntity {
  static const TABLE_NAME = 'keys';

  final int? id;
  final String content;
  final String receptionDateTime;

  KeyEntity({this.id, required this.content, required this.receptionDateTime});

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'receptionDateTime': receptionDateTime,
    };
  }

  static deleteKey(KeyEntity key) async {
    final db = await DBProvider.db.database;

    var res = await db.delete(TABLE_NAME, where: 'id=?', whereArgs: [key.id]);

    return res == 1;
  }

  static insertKey(KeyEntity key) async {
    final db = await DBProvider.db.database;

    // Insert Key
    var res = await db.insert(
      TABLE_NAME,
      key.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  static Future<int> count() async {
    final db = await DBProvider.db.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME'))!;
  }

  static Future<List<KeyEntity>> keys() async {
    final db = await DBProvider.db.database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return KeyEntity(
        id: maps[i]['id'],
        content: maps[i]['content'],
        receptionDateTime: maps[i]['receptionDateTime'],
      );
    });
  }
}
