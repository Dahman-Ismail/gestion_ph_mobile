// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_new_app/db/dao/produit_dao.dart';
import 'package:my_new_app/db/dao/user_dao.dart';
import 'package:my_new_app/model/Produit.dart';
import 'package:my_new_app/model/Users.dart';

class LoginService {
  final ProduitDao productDao = ProduitDao();
  final UserDao userDao = UserDao();

  Future<void> loginAndFetchData(String username, String password) async {
    // Assume we have a login function that returns a token or user details.
    final bool isLoggedIn = await _performLogin(username, password);
    
    if (isLoggedIn) {
      await fetchAndStoreProducts();
      await fetchAndStoreUsers();
    }
  }

  Future<bool> _performLogin(String username, String password) async {
    // This function simulates a login process.
    // Replace with actual login logic, possibly returning a token or user object.
    return true; // Assume login is always successful for demo purposes
  }

  Future<void> fetchAndStoreProducts() async {
    final response = await http.get(Uri.parse('http://192.168.1.106:8081/api/Produit/produits'));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = json.decode(response.body);
      List<Produit> products = productsJson.map((json) => Produit.fromMap(json)).toList();

      // Store products in local database
      for (var product in products) {
        await productDao.insertProduit(product);
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> fetchAndStoreUsers() async {
    final response = await http.get(Uri.parse('https://api.example.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> usersJson = json.decode(response.body);
      List<User> users = usersJson.map((json) => User.fromMap(json)).toList();

      // Store users in local database
      for (var user in users) {
        await userDao.insertUser(user);
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
}
