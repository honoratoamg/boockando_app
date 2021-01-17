import 'package:boockando_app/app/models/book.dart';
import 'package:boockando_app/app/repositories/local/database/db_consts.dart';
import 'package:boockando_app/app/repositories/local/database/db_helper.dart';
import 'package:boockando_app/app/repositories/local/database/db_queries.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class BookDao {
  /// Insert a book in your own table
  Future insertBook(Book book) async {
    try {
      final db = await DbHelper.getDatabase();

      await db.insert(
        TABLE_BOOK_NAME,
        book.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }

  /// Update a book in your own table
  Future<void> updateBook(Book book) async {
    final db = await DbHelper.getDatabase();

    await db.update(
      TABLE_BOOK_NAME,
      book.toJson(),
      where: "id = ?",
      whereArgs: [book.id],
    );
  }

  /// Permanently delete a book in your own table.
  Future<void> deleteBook(int id) async {
    final db = await DbHelper.getDatabase();

    await db.delete(
      TABLE_BOOK_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Returns a book, if he is on the table
  Future<Book> getBook({String bookTitle}) async {
    final db = await DbHelper.getDatabase();
    final tableName = TABLE_BOOK_NAME;
    final result = await db
        .rawQuery("SELECT * FROM '$tableName' WHERE name = '$bookTitle'");

    if (result.isNotEmpty) {
      return Book.fromJson(map: result.first);
    }

    return null;
  }

  /// Return a list of books
  Future<List<Book>> getBooks() async {
    try {
      final db = await DbHelper.getDatabase();
      final maps = await db.query(TABLE_BOOK_NAME);

      return List.generate(
        maps.length,
            (i) {
          return Book.fromJson(map: maps[i]);
        },
      );
    } catch (ex) {
      return <Book>[];
    }
  }

  Future<void> dropAndCreateBooks() async {
    try {
      final db = await DbHelper.getDatabase();
      await db.execute("DROP TABLE IF EXISTS ${TABLE_BOOK_NAME}");
      await db.execute(SCRIPT_CREATE_TABLE_BOOK_SQL);
    } catch (ex) {
      debugPrint("DBEXCEPTION: ${ex}");
    }
  }
}
