import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/produit_dao.dart';
import 'package:my_new_app/screen/about.dart';
import 'package:my_new_app/screen/allforni.dart';
import 'package:my_new_app/screen/login_screen.dart';
import 'package:my_new_app/service/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsScreen(),
    );
  }
}

Future<void> _showDoubleInputDialog(BuildContext context) async {
  final TextEditingController _doubleController = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter a value'),
        content: TextField(
          style: TextStyle(color: Colors.black),
          controller: _doubleController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Double value',
            hintText: 'Enter a number',
            hintStyle: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              if (_doubleController.text.isNotEmpty) {
                final double? value = double.tryParse(_doubleController.text);
                if (value != null) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setDouble('storedDouble', value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Value saved!')),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a valid number')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Field cannot be empty')),
                );
              }
            },
          ),
        ],
      );
    },
  );
}

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final ProduitDao _produitDao = ProduitDao(); // Instantiate your product DAO
  final ThemeService _themeService =
      ThemeService(); // Instantiate your ThemeService

  // Fetch the user's name from SharedPreferences
  Future<String?> _nameuser() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    return name;
  }

  Future<void> _deleteDatabase() async {
    await _produitDao.deleteAllProduits();
    print('Database cleared.');
  }

  Future<void> _signOut(BuildContext context) async {
    await _deleteDatabase(); // Delete database when logging out
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: primaryColor, // Use primary color from theme
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(
              Icons.person_2_sharp,
              color: Colors.blueAccent,
              size: 34,
            ),
            title: const Text('User Settings'),
            subtitle: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle profile edit tap
            },
          ),
          const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.favorite),
          //   title: const Text('Favourites'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     // Handle favourites tap
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.update),
            title: const Text('Update Chart'),
            onTap: () {
              _showDoubleInputDialog(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Supplier'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AllSupplierScreen()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.notifications),
          //   title: const Text('Notifications'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     // Handle notifications tap
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.lock),
          //   title: const Text('Privacy & Security'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     // Handle privacy & security tap
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.light_mode),
          //   title: const Text('Theme Switch'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () async {
          //     await _themeService.switchTheme();
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Term of use'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Privacy policy'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle help tap
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle sign-in tap
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}
