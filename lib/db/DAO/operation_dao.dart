import 'package:my_new_app/model/Operation.dart';
import 'package:my_new_app/db/db_helper.dart';




class OperationDao {
  final DBHelper _dbHelper = DBHelper();

  Future<int> insertOperation(Operation operation) async {
    final db = await _dbHelper.database;
    return await db.insert('operation', operation.toMap());
  }

  Future<List<Operation>> getOperations() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('operation');

    return List.generate(maps.length, (i) {
      return Operation.fromMap(maps[i]);
    });
  }

  Future<int> updateOperation(Operation operation) async {
    final db = await _dbHelper.database;
    return await db.update(
      'operation',
      operation.toMap(),
      where: 'id = ?',
      whereArgs: [operation.id],
    );
  }

}