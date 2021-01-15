import 'package:boockando_app/app/models/Basket.dart';
import 'package:boockando_app/app/models/user.dart';
import 'package:boockando_app/app/repositories/local/database/db_consts.dart';
import 'package:boockando_app/app/repositories/local/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class BasketDao {
  /// Insert a Basket in your own table
  Future insertBasket(Basket basket) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        TABLE_BASKET_NAME,
        basket.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Update a Basket in your own table
  Future<void> updateBasket(Basket basket) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      TABLE_BASKET_NAME,
      basket.toJson(),
      where: "id = ?",
      whereArgs: [basket.basketId],
    );
  }

  /// Permanently delete a Basket in your own table.
  Future<void> deleteBasket(int basketid) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      TABLE_BASKET_NAME,
      where: "${TABLE_BASKET_ATT_ID} = ?",
      whereArgs: [basketid],
    );
  }

  /// Return a list of Baskets
  Future<List<Basket>> getBaskets() async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(TABLE_BASKET_NAME);

      return List.generate(
        maps.length,
        (i) {
          return Basket.fromJson(map: maps[i]);
        },
      );
    } catch (ex) {
      return <Basket>[];
    }
  }

  /// returns a Basket by Id
  Future<User> getBasketById(int basketId) async {
    try {
      final db = await DbHelper.getDatabase();

      final result = await db
          .rawQuery("SELECT * FROM '$TABLE_USER_NAME' WHERE id = '$basketId'");

      if (result.isNotEmpty) {
        return User.fromJson(map: result.first);
      }

      return null;
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
      return null;
    }
  }
}
