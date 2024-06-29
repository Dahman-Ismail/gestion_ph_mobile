import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/produit_dao.dart';
import 'package:my_new_app/db/DAO/user_dao.dart';
import 'package:my_new_app/model/Produit.dart';
import 'package:my_new_app/screen/home_screen.dart';
import 'package:my_new_app/screen/login_screen.dart';
import 'package:my_new_app/screen/ip_page.dart'; // Make sure to import your IPPage
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_new_app/model/Users.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool _isLoggedIn = false;
  String? _ipAddress;

  final UserDao _userDao = UserDao();
  final ProduitDao _produitDao = ProduitDao();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    // _addTestUser().then((_) {});
    // _addTestProduit().then((_) {});
  }

  Future<void> _addTestUser() async {
    User testUser = User(
      id: 10,
      name: 'Test33 User',
      email: 'test@example353.com',
      password: 'password123',
      roleId: 1,
    );
    debugPrint("Adding test user: ${testUser.toMap()}");
    User? existingUser = await _userDao.getUserByEmail(testUser.email);
    if (existingUser == null) {
      await _userDao.insertUser(testUser);
      debugPrint("Test user added successfully");
    } else {
      debugPrint("Test user already exists: ${existingUser.toMap()}");
    }
  }

  Future<void> _addTestProduit() async {
    Produit testProduit = Produit(
      id: 2,
      fournisseurId: 1,
      image: 'https://via.placeholder.com/150',
      name: 'Test Product',
      barCode: 123456789,
      quantite: 100,
      PrixAchat: 10.99,
      PrixVente: 12.6,
      discount: 5,
      categoryId: 1,
      typeId: 1,
      description: 'Test product description',
      expirationDate: '2024-12-31',
      quantitePiece: 10,
    );
    print("Adding test product: ${testProduit.toMap()}");
    Produit? existingProduit = await _produitDao.getProductByBarCode(testProduit.barCode);
    if (existingProduit == null) {
      await _produitDao.insertProduit(testProduit);
      print("Test product added successfully");
    } else {
      print("Test product already exists: ${existingProduit.toMap()}");
    }
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final ipAddress = prefs.getString('userIP');

    setState(() {
      _isLoggedIn = isLoggedIn;
      _ipAddress = ipAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_ipAddress == null || _ipAddress!.isEmpty) {
      return IPPage();
    } else if (!_isLoggedIn) {
      return  const LoginScreen(); 
    } else {
      return const HomeScreen();
    }
  }
}
