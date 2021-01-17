import 'package:boockando_app/app/models/basket_books.dart';
import 'package:boockando_app/app/repositories/local/database/db_consts.dart';
import 'package:boockando_app/app/repositories/local/database/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class BasketBooksDao {
  /// insert a basketBooks in your own table
  Future insertBasketBooks(BasketBooks basketBooks) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        TABLE_BASKET_BOOKS_NAME,
        basketBooks.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Update a basketBooks
  Future<void> updateBasketBooks(BasketBooks basketBooks) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      TABLE_BASKET_BOOKS_NAME,
      basketBooks.toJson(),
      where: "${TABLE_BASKET_BOOKS_ATT_ID_USER} = ? and "
          "${TABLE_BASKET_BOOKS_ATT_ID_BOOK} = ? and"
          " ${TABLE_BASKET_BOOKS_ATT_ID_BASKET} = ?",
      whereArgs: [basketBooks.userId, basketBooks.bookId, basketBooks.basketId],
    );
  }

  /// Permanently deletes a BasketBooks
  Future<void> deleteBasketBooks(BasketBooks basketBooks) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      TABLE_BASKET_BOOKS_NAME,
      where: "${TABLE_BASKET_BOOKS_ATT_ID_USER} = ? and "
          "${TABLE_BASKET_BOOKS_ATT_ID_BOOK} = ? and"
          " ${TABLE_BASKET_BOOKS_ATT_ID_BASKET} = ?",
      whereArgs: [basketBooks.userId, basketBooks.bookId, basketBooks.basketId],
    );
  }

  /// Returns a list of BasketBooks of a user
  Future<List<BasketBooks>> getBasketBooksByUserId(
      int userId, int basketId) async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(TABLE_BASKET_BOOKS_NAME);

      final userBasketBooks = <BasketBooks>[];

      for (var i = 0; i < maps.length; i++) {
        if (maps[i][TABLE_BASKET_BOOKS_ATT_ID_USER] == userId &&
            maps[i][TABLE_BASKET_BOOKS_ATT_ID_BASKET] == basketId) {
          userBasketBooks.add(BasketBooks.fromJson(map: maps[i]));
        }
      }
      return userBasketBooks;
    } catch (ex) {
      return <BasketBooks>[];
    }
  }
}
