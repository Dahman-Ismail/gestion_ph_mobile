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
import 'package:my_new_app/db/DAO/user_dao.dart';
import 'package:my_new_app/screen/HomeScreen.dart';
// import 'package:my_new_app/screen/dashboard_screen.dart';
import 'package:my_new_app/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_new_app/model/Users.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool _isLoggedIn = false;
  final UserDao _userDao = UserDao();

 @override
void initState() {
  super.initState();
  _checkLoginStatus();
  _addTestUser().then((_) {
    _testLogin();
  });
}

  void _testLogin() async {
  // Using the correct credentials of the test user
  String email = 'test@example.com';
  String password = 'password123';

  User? user = await _userDao.getUserByEmail(email);
  if (user == null) {
    print('Test user not found');
  } else {
    print('Test user found: ${user.toMap()}');
    bool isValidUser = await _userDao.validateUser(email, password);
    if (isValidUser) {
      print('Test user credentials are valid');
    } else {
      print('Test user credentials are invalid');
    }
  }
}


  Future<void> _addTestUser() async {
  User testUser = User(
    name: 'Test User',
    email: 'test@example.com',
    password: 'password123',
    roleId: 1,
  );
  print("Adding test user: ${testUser.toMap()}");
  User? existingUser = await _userDao.getUserByEmail(testUser.email);
  if (existingUser == null) {
    await _userDao.insertUser(testUser);
    print("Test user added successfully");
  } else {
    print("Test user already exists: ${existingUser.toMap()}");
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
