import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pmscontrole.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE category (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      Name TEXT NOT NULL UNIQUE,
      Description TEXT NOT NULL
    )
    ''');


    await db.execute('''
    CREATE TABLE fournisseur (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      Name TEXT NOT NULL,
      Telephone INTEGER NOT NULL,
      email TEXT NOT NULL UNIQUE,
      Pays TEXT NOT NULL,
      Ville TEXT NOT NULL,
      Adresse TEXT NOT NULL,
      created_at TIMESTAMP NULL,
      updated_at TIMESTAMP NULL
    )
    ''');



    await db.execute('''
    CREATE TABLE operation (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      UserId INTEGER NOT NULL,
      ProduitId INTEGER NOT NULL,
      Nom TEXT NOT NULL,
      TotalPrice REAL NOT NULL,
      FOREIGN KEY (UserId) REFERENCES users (id) ON DELETE CASCADE,
      FOREIGN KEY (ProduitId) REFERENCES produit (id) ON DELETE CASCADE
    )
    ''');


    await db.execute('''
    CREATE TABLE produit (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      FournisseurId INTEGER NOT NULL,
      Image TEXT NOT NULL,
      Name TEXT NOT NULL,
      BarCode INTEGER NOT NULL,
      Quantite INTEGER NOT NULL,
      Price REAL NOT NULL,
      Discount INTEGER NOT NULL,
      CategoryId INTEGER NOT NULL,
      Description TEXT NOT NULL,
      ExpirrationDate DATE NOT NULL,
      created_at TIMESTAMP NULL,
      updated_at TIMESTAMP NULL,
      FOREIGN KEY (FournisseurId) REFERENCES fournisseur (id) ON DELETE CASCADE,
      FOREIGN KEY (CategoryId) REFERENCES category (id) ON DELETE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE roles (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      Role TEXT NOT NULL,
      guard_name TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      email_verified_at TIMESTAMP NULL,
      password TEXT NOT NULL,
      RoleId INTEGER NOT NULL,
      remember_token TEXT,
      created_at TIMESTAMP NULL,
      updated_at TIMESTAMP NULL,
      FOREIGN KEY (RoleId) REFERENCES roles (id) ON DELETE CASCADE
    )
    ''');
  }
}
