import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    Name VARCHAR(255),
    Description VARCHAR(255)
  )
  ''');


    await db.execute('''
      
      CREATE TABLE Type (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name VARCHAR(255),
        Description VARCHAR(255)
      )
   
     ''');

    await db.execute('''
     CREATE TABLE fournisseur (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(255),
    Telephone VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    Pays VARCHAR(255) ,
    Ville VARCHAR(255) ,
    Adresse VARCHAR(255)
  )
  ''');

        await db.execute('''
  CREATE TABLE operation (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    TotalPrice DOUBLE , 
    date DATE 
  )
  ''');

    await db.execute('''
    CREATE TABLE produit (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    FournisseurId INTEGER,
    TypeId INTEGER,
    Image VARCHAR(255),
    Name VARCHAR(255),
    BarCode INTEGER,   
    Quantite INTEGER,
    QuantitePiece INTEGER,
    PrixAchat DOUBLE,
    PrixVente DOUBLE,
    Discount INTEGER,
    CategoryId INTEGER,
    Description VARCHAR(255),
    ExpirationDate DATE,
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
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    email_verified_at TIMESTAMP,
    password VARCHAR(255),
    RoleId INTEGER,
    remember_token VARCHAR(255),
    FOREIGN KEY (RoleId) REFERENCES roles (id) ON DELETE CASCADE
  )
  ''');
  }


}
