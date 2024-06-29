import 'package:my_new_app/model/type.dart';
import 'package:my_new_app/db/db_helper.dart';


class TypeDao {
  final DBHelper _dbHelper = DBHelper();

  Future<Type?> getTypeById(int id) async {
    final db = await _dbHelper.database;

    List<Map<String, dynamic>> maps = await db.query(
      'Type', // Table name
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      print('Fetched data: ${maps.first}'); // Debugging line
      return Type.fromMap(maps.first); // Convert the first result to a Type object
    }

    return null; // Return null if no type is found
  }
  Future<int> insertType(Type type) async {
    final db = await _dbHelper.database;
    return await db.insert('Type', type.toMap());
  }

  Future<List<Type>> getTypes() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Type');

    return List.generate(maps.length, (i) {
      return Type.fromMap(maps[i]);
    });
  }

  Future<int> updateType(Type type) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Type',
      type.toMap(),
      where: 'id = ?',
      whereArgs: [type.id],
    );
  }

  Future<int> deleteType(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Type',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}