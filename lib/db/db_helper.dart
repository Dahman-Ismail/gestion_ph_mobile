import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    String path = join(await getDatabasesPath(), 'pmscontrole6.db');
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
    Name VARCHAR(255) NOT NULL UNIQUE,
    Description VARCHAR(255)
  )
  ''');


    await db.execute('''
      
      CREATE TABLE Type (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name VARCHAR(255) NOT NULL,
        Description VARCHAR(255)
      )
   
     ''');

    await db.execute('''
     CREATE TABLE fournisseur (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(255) NOT NULL,
    Telephone VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    Pays VARCHAR(255) ,
    Ville VARCHAR(255) ,
    Adresse VARCHAR(255)
  )
  ''');

    await db.execute('''
  CREATE TABLE operation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    UserId INTEGER NOT NULL,
    ProduitId INTEGER NOT NULL,
    Quantite INTEGER ,
    QuantitePiece INTEGER , 
    TypeOperation VARCHAR(255) , 
    Nom VARCHAR(255) NOT NULL,
    TotalPrice REAL NOT NULL,
    FOREIGN KEY (UserId) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (ProduitId) REFERENCES produit (id) ON DELETE CASCADE
  )
  ''');

    await db.execute('''
    CREATE TABLE produit (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    FournisseurId INTEGER NOT NULL,
    TypeId INTEGER NOT NULL,
    Image VARCHAR(255),
    Name VARCHAR(255) NOT NULL,
    BarCode INTEGER NOT NULL,   
    Quantite INTEGER NOT NULL,
    QuantitePiece INTEGER NOT NULL,
    Price DOUBLE NOT NULL,
    Discount INTEGER,
    CategoryId INTEGER NOT NULL,
    Description VARCHAR(255),
    ExpirationDate DATE NOT NULL,
    FOREIGN KEY (FournisseurId) REFERENCES fournisseur (id) ON DELETE CASCADE,
    FOREIGN KEY (CategoryId) REFERENCES category (id) ON DELETE CASCADE , 
    FOREIGN KEY (TypeId) REFERENCES Type (id) ON DELETE CASCADE
  )
  ''');


    await db.execute('''
  CREATE TABLE roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    Role VARCHAR(255) NOT NULL,
    guard_name VARCHAR(255)
  )
  ''');

    await db.execute('''
  CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    email_verified_at TIMESTAMP,
    password VARCHAR(255) NOT NULL,
    RoleId INTEGER NOT NULL,
    remember_token VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (RoleId) REFERENCES roles (id) ON DELETE CASCADE
  )
  ''');
  }


}