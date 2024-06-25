import 'package:my_new_app/db/db_helper.dart';
import 'package:my_new_app/model/Fournisseur.dart';


class FournisseurDao {
  final DBHelper _dbHelper = DBHelper();

  Future<int> insertFournisseur(Fournisseur fournisseur) async {
    final db = await _dbHelper.database;
    return await db.insert('fournisseur', fournisseur.toMap());
  }

  Future<List<Fournisseur>> getFournisseurs() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('fournisseur');

    return List.generate(maps.length, (i) {
      return Fournisseur.fromMap(maps[i]);
    });
  }

  Future<int> updateFournisseur(Fournisseur fournisseur) async {
    final db = await _dbHelper.database;
    return await db.update(
      'fournisseur',
      fournisseur.toMap(),
      where: 'id = ?',
      whereArgs: [fournisseur.id],
    );
  }

  
}