import 'package:boockando_app/app/models/purchase.dart';
import 'package:boockando_app/app/repositories/local/database/db_consts.dart';
import 'package:boockando_app/app/repositories/local/database/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class PurchaseDao {
  /// insert a purchase in your own table
  Future insertPurchase(Purchase purchase) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        TABLE_PURCHASE_NAME,
        purchase.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Update a purchase
  Future<void> updateJob(Purchase purchase) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      TABLE_PURCHASE_NAME,
      purchase.toMap(),
      where: "${TABLE_BASKET_BOOKS_ATT_ID_USER} = ? and "
          " ${TABLE_BASKET_BOOKS_ATT_ID_BASKET} = ?",
      whereArgs: [purchase.userId, purchase.basketId],
    );
  }

  /// Permanently deletes a Purchase
  Future<void> deletePurchase(Purchase purchase) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      TABLE_PURCHASE_NAME,
      where: "${TABLE_BASKET_BOOKS_ATT_ID_USER} = ? and "
          " ${TABLE_BASKET_BOOKS_ATT_ID_BASKET} = ?",
      whereArgs: [purchase.userId, purchase.basketId],
    );
  }

  /// Returns a list of Purchase of a user
  Future<List<Purchase>> getPurchaseByUserId(int userId, int basketId) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(TABLE_PURCHASE_NAME);

      final userPurchase = <Purchase>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i][TABLE_PURCHASE_ATT_USER_ID] == userId &&
            maps[i][TABLE_PURCHASE_ATT_BASKET_ID] == basketId) {
          userPurchase.add(Purchase.fromMap(map: maps[i]));
        }
      }
      return userPurchase;
    } catch (ex) {
      return <Purchase>[];
    }
  }
}
