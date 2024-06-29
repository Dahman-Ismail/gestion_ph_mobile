import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_new_app/db/DAO/operation_dao.dart';
import 'package:my_new_app/db/DAO/produit_dao.dart';
import 'package:my_new_app/db/DAO/role_dao.dart';
import 'package:my_new_app/db/DAO/user_dao.dart';
import 'package:my_new_app/db/DAO/category_dao.dart';
import 'package:my_new_app/db/DAO/fournisseur_dao.dart';
import 'package:my_new_app/db/DAO/type_dao.dart';
import 'package:my_new_app/model/Operation.dart';
import 'package:my_new_app/model/Produit.dart';
import 'package:my_new_app/model/Users.dart';
import 'package:my_new_app/model/Category.dart';
import 'package:my_new_app/model/Fournisseur.dart';
import 'package:my_new_app/model/role.dart';
import 'package:my_new_app/model/type.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginService {
  final ProduitDao productDao = ProduitDao();
  final UserDao userDao = UserDao();
  final CategoryDao categoryDao = CategoryDao();
  final FournisseurDao fournisseurDao = FournisseurDao();
  final TypeDao typeDao = TypeDao();
  final OperationDao operationDao = OperationDao();
  final RoleDao roleDao = RoleDao();


  Future<void> loginAndFetchData() async {
   
      await fetchAndStoreProducts();
      await fetchAndStoreUsers();
      await fetchAndStoreCategories();
      await fetchAndStoreFournisseurs();
      await fetchAndStoreTypes();
      await fetchAndStoreOperations(); 
      await fetchAndStoreRoles(); 
  }

  Future<void> fetchAndStoreProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIP = prefs.getString('userIP'); // Default IP if not set

    String url = 'http://$userIP:8080/api/Produit/produits';
    final response = await http.get(Uri.parse(url));
    // final response = await http.get(Uri.parse('http://192.168.1.106:8080/api/Produit/produits'));

    if (response.statusCode == 200) {
      List<dynamic> productsJson = json.decode(response.body);
      List<Produit> products = productsJson.map((json) => Produit.fromMap(json)).toList();

      for (var product in products) {
        final existingProduct = await productDao.getProductByBarCode(product.barCode);

        if (existingProduct == null) {
          await productDao.insertProduit(product);
        } else if (!_areProductsEqual(existingProduct, product)) {
          await productDao.updateProduit(product);
        }
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> fetchAndStoreUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIP = prefs.getString('userIP'); // Default IP if not set

    String url = 'http://$userIP:8080/api/User/users';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> usersJson = json.decode(response.body);
      List<User> users = usersJson.map((json) => User.fromMap(json)).toList();

      for (var user in users) {
        final existingUser = await userDao.getUserByEmail(user.email);

        if (existingUser == null) {
          await userDao.insertUser(user);
        } else if (!_areUsersEqual(existingUser, user)) {
          await userDao.updateUser(user);
        }
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> fetchAndStoreCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIP = prefs.getString('userIP'); // Default IP if not set

    String url = 'http://$userIP:8080/api/Category/categories';
    final response = await http.get(Uri.parse(url));
    // final response = await http.get(Uri.parse('http://192.168.1.106:8080/api/Category/categories'));

    if (response.statusCode == 200) {
      List<dynamic> categoriesJson = json.decode(response.body);
      List<Category> categories = categoriesJson.map((json) => Category.fromMap(json)).toList();

      for (var category in categories) {
        final existingCategory = await categoryDao.getCategoryById(category.id as int);

        if (existingCategory == null) {
          await categoryDao.insertCategory(category);
        } else if (!_areCategoriesEqual(existingCategory, category)) {
          await categoryDao.updateCategory(category);
        }
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchAndStoreFournisseurs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIP = prefs.getString('userIP'); // Default IP if not set

    String url = 'http://$userIP:8080/api/Fournisseur/fournisseurs';
    final response = await http.get(Uri.parse(url));
  // final response = await http.get(Uri.parse('http://192.168.1.106:8080/api/Fournisseur/fournisseurs'));

  if (response.statusCode == 200) {
    List<dynamic> fournisseursJson = json.decode(response.body);
    List<Fournisseur> fournisseurs = fournisseursJson.map((json) => Fournisseur.fromMap(json)).toList();

    for (var fournisseur in fournisseurs) {
      // var fournis = fournisseur.id; // Remove this line
      // fournisInt = int.ParseInt(fournis); // Remove this line
final existingFournisseur = await fournisseurDao.getFournisseurById(fournisseur.id!);

      if (existingFournisseur == null) {

        await fournisseurDao.insertFournisseur(fournisseur);
      } else if (!_areFournisseursEqual(existingFournisseur, fournisseur)) {
        await fournisseurDao.updateFournisseur(fournisseur);
      }
    }
  } else {
    throw Exception('Failed to load fournisseurs');
  }
}

  Future<void> fetchAndStoreTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIP = prefs.getString('userIP'); // Default IP if not set

    String url = 'http://$userIP:8080/api/Type/types';
    final response = await http.get(Uri.parse(url));
  // final response = await http.get(Uri.parse('http://192.168.1.106:8080/api/Type/types'));

  if (response.statusCode == 200) {
    List<dynamic> typesJson = json.decode(response.body);
    List<Type> types = typesJson.map((json) => Type.fromMap(json)).toList();

    for (var type in types) {
      final existingType = await typeDao.getTypeById(type.id as int);

      if (existingType == null) {
        await typeDao.insertType(type);
      } else if (!_areTypesEqual(existingType, type)) {
        await typeDao.updateType(type);
      }
    }
  } else {
    throw Exception('Failed to load types');
  }
}


Future<void> fetchAndStoreRoles() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIP = prefs.getString('userIP'); // Default IP if not set

    String url = 'http://$userIP:8080/api/Role/roles';
    final response = await http.get(Uri.parse(url));
    // final response = await http.get(Uri.parse('http://192.168.1.106:8080/api/Role/roles'));

    if (response.statusCode == 200) {
      List<dynamic> rolesJson = json.decode(response.body);
      List<Role> roles = rolesJson.map((json) => Role.fromMap(json)).toList();

      for (var role in roles) {
        final existingRole = await roleDao.getRoleById(role.id!);

        if (existingRole == null) {
          await roleDao.insertRole(role);
        } else if (!_areRolesEqual(existingRole, role)) {
          await roleDao.updateRole(role);
        }
      }
    } else {
      throw Exception('Failed to load roles');
    }
  }
  Future<void> fetchAndStoreOperations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIP = prefs.getString('userIP'); // Default IP if not set

    String url = 'http://$userIP:8080/api/Operation/operations';
    final response = await http.get(Uri.parse(url));
    // final response = await http.get(Uri.parse('http://192.168.1.106:8080/api/Operation/operations'));

    if (response.statusCode == 200) {
      List<dynamic> operationsJson = json.decode(response.body);
      List<Operation> operations = operationsJson.map((json) => Operation.fromMap(json)).toList();

      for (var operation in operations) {
        final existingOperation = await operationDao.getOperationById(operation.id!);

        if (existingOperation == null) {
          await operationDao.insertOperation(operation);
        } else if (!_areOperationsEqual(existingOperation, operation)) {
          await operationDao.updateOperation(operation);
        }
      }
    } else {
      throw Exception('Failed to load operations');
    }
  }
  bool _areProductsEqual(Produit p1, Produit p2) {
    print("i am her so it is a produit");

    return p1.name == p2.name &&
           p1.barCode == p2.barCode &&
           p1.quantite == p2.quantite &&
           p1.PrixAchat == p2.PrixAchat &&
           p1.PrixVente == p2.PrixVente &&
           p1.discount == p2.discount &&
           p1.categoryId == p2.categoryId &&
           p1.typeId == p2.typeId &&
           p1.description == p2.description &&
           p1.expirationDate == p2.expirationDate &&
           p1.quantitePiece == p2.quantitePiece &&
           p1.image == p2.image;
  }

  bool _areUsersEqual(User u1, User u2) {
    return u1.name == u2.name &&
           u1.email == u2.email &&
           u1.password == u2.password &&
           u1.roleId == u2.roleId;
  }

  bool _areCategoriesEqual(Category c1, Category c2) {
    print("i am her so it is a  category");

    return c1.name == c2.name &&
           c1.description == c2.description;
  }

  bool _areFournisseursEqual(Fournisseur f1, Fournisseur f2) {
    print("i am her idan kayen forni");

    return f1.name == f2.name &&
           f1.telephone == f2.telephone &&
           f1.email == f2.email &&
           f1.pays == f2.pays &&
           f1.ville == f2.ville &&
           f1.adresse == f2.adresse;
  }

  bool _areTypesEqual(Type t1, Type t2) {
    print("i am her idan kayen type");

    return t1.name == t2.name &&
           t1.description == t2.description;
  }



  bool _areOperationsEqual(Operation o1, Operation o2) {
    print("i am her idan kayen operation");

    return o1.userId == o2.userId &&
           o1.produitId == o2.produitId &&
           o1.nom == o2.nom &&
           o1.totalPrice == o2.totalPrice ;
          
  }

  bool _areRolesEqual(Role r1, Role r2) {
    print("i am her idan kayen role");

    return r1.role == r2.role &&
           r1.guardName == r2.guardName;
  }
}
