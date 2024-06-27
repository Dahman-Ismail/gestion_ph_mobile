import 'package:flutter/material.dart';
import 'package:my_new_app/screen/about.dart';
import 'package:my_new_app/screen/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_new_app/db/dao/produit_dao.dart'; // Import your product DAO here
import 'package:my_new_app/screen/login_screen.dart';
import 'package:my_new_app/service/theme_service.dart'; // Import your ThemeService here

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final ProduitDao _produitDao = ProduitDao(); // Instantiate your product DAO
  final ThemeService _themeService = ThemeService(); // Instantiate your ThemeService

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
        title: const Text('Settings'),
        backgroundColor: primaryColor, // Use primary color from theme
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          FutureBuilder<String?>(
            future: _nameuser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error fetching user data');
              } else {
                final userName = snapshot.data ?? 'Unknown User';
                return ListTile(
                  // leading: CircleAvatar(
                  //   backgroundImage: NetworkImage('https://example.com/user.jpg'), // Replace with actual avatar image URL or local asset
                  // ),
                  subtitle: Text(userName),
                );
              }
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
            leading: const Icon(Icons.download),
            title: const Text('Downloads'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle downloads tap
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Account()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle notifications tap
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.lock),
          //   title: const Text('Privacy & Security'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     // Handle privacy & security tap
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.light_mode),
            title: const Text('Theme Switch'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              await _themeService.switchTheme();
            },
          ),
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
