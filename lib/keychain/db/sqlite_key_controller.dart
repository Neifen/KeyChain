import 'package:key_chain/app_constrains/db_provider.dart';
import 'package:key_chain/keychain/db/key_controller_state.dart';
import 'package:sqflite/sqflite.dart';

import 'key_entity.dart';

class SQLiteKeyController implements IKeyControllerState {
  static const TABLE_NAME = 'keys';

  @override
  removeKey(KeyEntity key) async {
    final db = await DBProvider.db.database;

    var res = await db.delete(TABLE_NAME, where: 'id=?', whereArgs: [key.id]);

    return res == 1;
  }

  @override
  deleteAll() async {
    final db = await DBProvider.db.database;
    return await db.delete(TABLE_NAME);
  }

  @override
  insertKey(KeyEntity key) async {
    final db = await DBProvider.db.database;

    // Insert Key
    var res = await db.insert(
      TABLE_NAME,
      key.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  @override
  insertAll(List<KeyEntity> keys) async {
    keys.forEach((element) {
      insertKey(element);
    });
  }

  @override
  Future<int> count() async {
    final db = await DBProvider.db.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME'))!;
  }

  @override
  Future<List<KeyEntity>> keys() async {
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
