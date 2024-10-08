import 'package:my_new_app/model/role.dart';
import 'package:my_new_app/db/db_helper.dart';

class RoleDao {
  final DBHelper _dbHelper = DBHelper();

  Future<int> insertRole(Role role) async {
    final db = await _dbHelper.database;
    return await db.insert('roles', role.toMap());
  }

  Future<List<Role>> getRoles() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('roles');

    return List.generate(maps.length, (i) {
      return Role.fromMap(maps[i]);
    });
  }

  Future<Role?> getRoleById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'roles',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Role.fromMap(maps.first);
    } else {
      return null; // Return null if no role found with the given ID
    }
  }

  Future<int> updateRole(Role role) async {
    final db = await _dbHelper.database;
    return await db.update(
      'roles',
      role.toMap(),
      where: 'id = ?',
      whereArgs: [role.id],
    );
  }
}
