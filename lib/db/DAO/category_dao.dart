import 'package:my_new_app/db/db_helper.dart';
import 'package:my_new_app/model/Category.dart';

class CategoryDao {
  final DBHelper _dbHelper = DBHelper();

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