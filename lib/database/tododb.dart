import 'package:sqflite/sqflite.dart';

class TodoDB {
  final tableName = "todo";

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName(
        ""id"" INTEGER NOT NULL,
        ""title"" TEXT NOT NULL,
        ""created_at"" INTEGER NOT NULL DEFAULT(cast(strftime('%s','now') )
        ""updated_at"" INTEGER,
        PRIMARY KEY("id" AUTOINCREMENT));
        """);
  }
}
