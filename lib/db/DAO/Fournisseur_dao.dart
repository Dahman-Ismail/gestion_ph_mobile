import 'package:my_new_app/db/db_helper.dart';
import 'package:my_new_app/model/Fournisseur.dart';


class FournisseurDao {
  final DBHelper _dbHelper = DBHelper();

Future<Fournisseur?> getFournisseurById(int id) async {
    final db = await _dbHelper.database;

    List<Map<String, dynamic>> maps = await db.query(
      'fournisseur', // Table name
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Fournisseur.fromMap(maps.first); // Convert the first result to a Fournisseur object
    }

    return null; // Return null if no fournisseur is found
  }

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