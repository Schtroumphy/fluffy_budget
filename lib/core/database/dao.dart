import 'package:fluffy_budget/core/extensions/string_extension.dart';
import 'package:sqflite/sqflite.dart';

abstract class Dao<T> {
  Dao({required this.tableName});

  final String tableName;

  Future<Database> get database;

  Future<R> withDatabase<R>(Future<R> Function(Database) callback) {
    return database.then(callback);
  }

  Future<R> withTransaction<R>(Future<R> Function(Transaction) callback) {
    return withDatabase((db) => db.transaction(callback));
  }

  Future<List<Map<String, Object?>>> rawQuery(String sql, [List<Object?>? arguments]) {
    return withDatabase((db) => db.rawQuery(sql, arguments));
  }

  /* ----------- CONVERSION ----------- */

  Map<String, dynamic> toEntity(T model);

  List<Map<String, dynamic>> toEntities(List<T> models) {
    return models.map((e) => toEntity(e)).toList();
  }

  T toModel(Map<String, dynamic> entity);

  List<T>? toModels(List<Map<String, Object?>> entities) {
    return entities.map((e) => toModel(e)).toList();
  }

  /* ----------- FETCHING ----------- */

  Future<List<T>?> getAll() async {
    final entities = await withDatabase((db) => db.query(tableName));
    return toModels(entities);
  }

  Future<List<T>?> queryItems({String? where, List<String>? args}) async {
    final entities = await withDatabase(
          (db) => db.query(
        tableName,
        where: where,
        whereArgs: args,
      ),
    );
    return toModels(entities);
  }

  Future<T?> queryFirstItem(String where, List<String> args) async {
    final entities = await withDatabase(
      (db) => db.query(
        tableName,
        where: where,
        whereArgs: args,
        limit: 1,
      ),
    );
    final res = entities.firstOrNull;

    if(res == null) return null;

    return toModel(res);
  }

  /* ----------- SAVING / UPDATING ----------- */

  Future<void> save(T model) async {
    await withDatabase(
      (db) => db.insert(
        tableName,
        toEntity(model),
      ),
    );
  }

  Future<void> saveAll(Iterable<T> models) async {

    final entities = toEntities(models.toList());

    if(entities.isEmpty) return;

    final values = List.generate(entities.length, (i) => entities.first.keys.valuesMarkSqlFields).join(",");
    final sql = 'INSERT INTO $tableName VALUES $values';
    final fieldExpand = entities.map((e) => e.values).map((e) => e).expand((e) => e).toList();

    /* EXPECTED 'INSERT INTO Test(name, value, num) VALUES (?, ?, ?), (?, ?, ?) ...' */

    await withDatabase((db) async {
      final batch = db.batch();
      batch.execute(sql, fieldExpand);
      await batch.commit(noResult: true);
    });
  }

  /* ----------- COUNTING ----------- */
  Future<bool> isEmpty({String? where, List<String>? args}) async {
    String sql = 'SELECT COUNT(*) FROM $tableName';

    if (where != null) sql += ' WHERE $where';

    final count = (Sqflite.firstIntValue(await withDatabase((db) => db.rawQuery(sql, args ?? []))));

    return  count == 0;
  }

  /* ----------- DELETING ----------- */
  Future<void> delete(String where, List<String> args) async {
    withDatabase((db) => db.delete(
          tableName,
          where: where,
          whereArgs: args,
        ));
  }
}
