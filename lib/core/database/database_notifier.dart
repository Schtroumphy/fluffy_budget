import 'package:fluffy_budget/common/exceptions/database_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

part 'database_notifier.g.dart';

@riverpod
class DatabaseNotifier extends _$DatabaseNotifier {
  static const defaultPath = 'fluffy_budget.db';
  static const versionKey = 'versionKey';
  static const version = 1;

  DatabaseNotifier([this._path = defaultPath]);

  final String _path;

  @override
  Future<Database> build() async {
    final prefs = await SharedPreferences.getInstance();
    final oldVersion = prefs.getInt(versionKey);

    final deleteBefore = oldVersion != null && oldVersion > version;

    Future<Database> db;
    try {
      db = createDatabase(
        _path,
        deleteBefore,
      );
    } catch (_) {
      if (deleteBefore) {
        throw DatabaseCreationException();
      }

      db = createDatabase(_path, true);
    }

    return db;
  }

  Future<Database> createDatabase(
    String path, [
    bool deleteBefore = false,
  ]) async {
    if (deleteBefore) {
      await deleteDatabase(path);
    }
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) => migrate(db, 0, version),
      onUpgrade: migrate,
    );
  }


  Future<void> migrate(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
        CREATE TABLE drop_down_item (
          id             INTEGER PRIMARY KEY AUTOINCREMENT,
          label          TEXT,
          icon           TEXT,
          color          TEXT,
          type           TEXT
        )
    ''');
  }
}
