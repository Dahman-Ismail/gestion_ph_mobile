
import 'package:my_new_app/model/Users.dart';
import 'package:my_new_app/db/db_helper.dart';


class UserDao {
  final DBHelper _dbHelper = DBHelper();

  Future<int> insertUser(User user) async {
    final db = await _dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

}
