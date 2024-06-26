import 'package:my_new_app/model/Produit.dart';
import 'package:my_new_app/db/db_helper.dart';



class ProduitDao {
  final DBHelper _dbHelper = DBHelper();


// Method to get a product by barCode from the database
  Future<Produit?> getProductByBarCode(int barCode) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'produits',
      where: 'barCode = ?',
      whereArgs: [barCode],
    );

    if (maps.isNotEmpty) {
      return Produit.fromMap(maps.first);
    }
    return null;
  }


  Future<int> insertProduit(Produit produit) async {
    final db = await _dbHelper.database;
    return await db.insert('produit', produit.toMap());
  }

  Future<List<Produit>> getProduits() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('produit');

    return List.generate(maps.length, (i) {
      return Produit.fromMap(maps[i]);
    });
  }

   Future<int> updateProduit(Produit produit) async {
    final db = await _dbHelper.database;
    return await db.update(
      'produit',
      produit.toMap(),
      where: 'id = ?',
      whereArgs: [produit.id],
    );
  }

  
}