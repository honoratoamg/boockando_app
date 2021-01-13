import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/repositories/local/database/db_consts.dart';
import 'package:boockando_app/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class UserDao {
  /// Insert a user in your own table
  Future insertUser(User user) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        TABLE_USER_NAME,
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Update a user in your own table
  Future<void> updateUser(User user) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      TABLE_USER_NAME,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.userId],
    );
  }

  /// Permanently delete a user in your own table.
  Future<void> deleteUser(int id) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      TABLE_USER_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Returns a user, if he is on the table
  Future<User> getUser({String username}) async {
    final db = await DbHelper.getDatabase();
    final tableName = TABLE_USER_NAME;
    final result = await db
        .rawQuery("SELECT * FROM '$tableName' WHERE name = '$username'");

    if (result.isNotEmpty) {
      return User.fromMap(map: result.first);
    }

    return null;
  }

  /// Return a list of users
  Future<List<User>> getUsers() async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(TABLE_USER_NAME);

      return List.generate(
        maps.length,
            (i) {
          return User.fromMap(map: maps[i]);
        },
      );
    } catch (ex) {
      return <User>[];
    }
  }
}
