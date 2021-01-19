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
        purchase.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Update a purchase
  Future<void> updatePurchase(Purchase purchase) async {
    final db = await DbHelper.getDatabase();
    await db.update(
      TABLE_PURCHASE_NAME,
      purchase.toJson(),
      where: "${TABLE_PURCHASE_ATT_ID} = ?",
      whereArgs: [purchase.id],
    );
  }

  /// Permanently deletes a Purchase
  Future<void> deletePurchase(int purchaseId) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      TABLE_PURCHASE_NAME,
      where: "${TABLE_PURCHASE_ATT_USER_ID} = ?",
      whereArgs: [purchaseId],
    );
  }

  /// Returns a list of Purchase of a user
  Future<List<Purchase>> getAllUserPurchases(int userId) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(TABLE_PURCHASE_NAME);

      final userPurchase = <Purchase>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i][TABLE_PURCHASE_ATT_USER_ID] == userId) {
          if (maps[i][TABLE_PURCHASE_ATT_IS_DELETED] == 0) {
            userPurchase.add(Purchase.fromJson(map: maps[i]));
          }
        }
      }
      return userPurchase;
    } catch (ex) {
      return <Purchase>[];
    }
  }

}
