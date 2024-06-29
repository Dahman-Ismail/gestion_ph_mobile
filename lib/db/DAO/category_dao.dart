import 'package:my_new_app/db/db_helper.dart';
import 'package:my_new_app/model/Category.dart';

class CategoryDao {
  final DBHelper _dbHelper = DBHelper();


  Future<Category?> getCategoryById(int id) async {
    final db = await _dbHelper.database;
    List<Map<String, dynamic>> maps = await db.query(
      'category', // Table name
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Category.fromMap(maps.first); // Convert the first result to a Category object
    }

    return null; // Return null if no category is found
  }


  Future<int> insertCategory(Category category) async {
    final db = await _dbHelper.database;
    return await db.insert('category', category.toMap());
  }

  Future<List<Category>> getCategories() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('category');

    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  Future<int> updateCategory(Category category) async {
    final db = await _dbHelper.database;
    return await db.update(
      'category',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }


  
}