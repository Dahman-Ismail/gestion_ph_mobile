import 'package:my_new_app/db/db_helper.dart';
import 'package:my_new_app/model/Users.dart';

class UserDao {
  final DBHelper _dbHelper = DBHelper();

  Future<List<User>> getUsers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<int> insertUser(User user) async {
    final db = await _dbHelper.database;
    int result = await db.insert('users', user.toMap());
    print('User inserted with id: $result');
    return result;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      print('User found with email: $email');
      return User.fromMap(maps.first);
    }
    print('No user found with email: $email');
    return null;
  }

  Future<int> updateUser(User user) async {
    final db = await _dbHelper.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }


  Future<void> deleteAllUsers() async {
    final db = await _dbHelper.database;
    await db.delete('users');
  }

  Future<bool> validateUser(String email, String password) async {
    User? user = await getUserByEmail(email);
    if (user != null && user.password == password) {
      print('Password matches for user with email: $email');
      return true;
    }
    print('Invalid credentials for email: $email');
    return false;
  }
}
