import 'package:flutter/material.dart';
import 'package:my_new_app/screen/employee_dashboard_screen.dart';
import 'package:my_new_app/screen/product_ashboard_screen.dart';
import 'settings_screen.dart';
import 'dashboard_screen.dart';
// import 'product_dashboard_screen.dart';
// import 'employee_dashboard_screen.dart';
// import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.page});
  final int? page;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const ProductDashboardScreen(),
    const EmployeeDashboardScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.page ?? 0;
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
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueGrey,
        backgroundColor:
            const Color(0xFF0084FF), // The blue color from your image
        onTap: _onItemTapped,
      ),
    );
  }
}
