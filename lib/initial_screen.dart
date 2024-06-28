// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'screen/login_screen.dart';
// import 'screen/dashboard_screen.dart'; 

// class InitialScreen extends StatefulWidget {
//   const InitialScreen({Key? key}) : super(key: key);

//   @override
//   _InitialScreenState createState() => _InitialScreenState();
// }

// class _InitialScreenState extends State<InitialScreen> {
//   bool _isLoggedIn = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }

//   Future<void> _checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     setState(() {
//       _isLoggedIn = isLoggedIn;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoggedIn) {
//       return const DashboardScreen();
//     } else {
//       return const LoginScreen();
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/produit_dao.dart';
import 'package:my_new_app/db/DAO/user_dao.dart';
import 'package:my_new_app/model/Produit.dart';
import 'package:my_new_app/screen/home_screen.dart';
import 'package:my_new_app/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_new_app/model/Users.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool _isLoggedIn = false;
  final UserDao _userDao = UserDao();
  final ProduitDao _produitDao = ProduitDao();

 @override
void initState() {
  super.initState();
  _checkLoginStatus();
  _addTestUser().then((_) {
  });
  _addTestProduit().then((_) {
  });
}



  Future<void> _addTestUser() async {
    User testUser = User(
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
      expirationDate: '2024-12-31', // Correct the typo here
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

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
