import 'package:my_new_app/model/Produit.dart';
import 'package:my_new_app/db/db_helper.dart';



class ProduitDao {
  final DBHelper _dbHelper = DBHelper();

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

  
}