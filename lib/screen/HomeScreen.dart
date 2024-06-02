import 'package:flutter/material.dart';
import 'package:my_new_app/screen/EmployeeDashboardScreen.dart';
import 'package:my_new_app/screen/ProductDashboardScreen.dart';
import 'SettingsScreen.dart';
import 'dashboard_screen.dart';
// import 'product_dashboard_screen.dart';
// import 'employee_dashboard_screen.dart';
// import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    ProductDashboardScreen(),
    EmployeeDashboardScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 146, 75, 75),
        unselectedItemColor: Color.fromARGB(137, 221, 8, 8),
        backgroundColor: Color(0xFF0084FF),  // The blue color from your image
        onTap: _onItemTapped,
      ),
    );
  }
}
