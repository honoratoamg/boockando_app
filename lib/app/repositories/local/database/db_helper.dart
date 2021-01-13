import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_consts.dart';
import 'db_queries.dart';

class DbHelper {
  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(SCRIPT_CREATE_TABLE_USER_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_BOOK_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_BASKET_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_BASKET_BOOKS_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_PURCHASE_SQL);
      },
      version: 1,
    );
  }
}
