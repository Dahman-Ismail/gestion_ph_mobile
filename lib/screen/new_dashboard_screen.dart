import 'package:flutter/material.dart';
import 'all_products_screen.dart';

class NewDashboardScreen extends StatelessWidget {
  const NewDashboardScreen({Key? key}) : super(key: key);
  
  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCard('Order', 'From 85 Product Provider', Icons.shopping_cart, Colors.blue),
                _buildCard('Providers', 'You Have 85 Product Provider', Icons.store, Colors.purple),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildProductTable(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('12,404 other product'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AllProductScreen()),
                    );
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCard('Manage', 'Manage your Products', Icons.settings, Colors.blue),
                _buildCard('Discounts', 'Make some offers on your Products', Icons.discount, Colors.purple),
              ],
            ),
            const SizedBox(height: 20),
            _buildCard('Products Analysis', 'See all the Analysis of your products', Icons.analytics, Colors.teal, large: true),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, IconData icon, Color color, {bool large = false}) {
    
    return Card(
      child: Container(
        width: large ? double.infinity : (MediaQuery.of(context!).size.width / 2) - 24,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTable() {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(30),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(60),
        3: FixedColumnWidth(60),
      },
      border: TableBorder.all(color: Colors.grey),
      children: [
        _buildTableRow('N.', 'Name', 'Quantity', 'Price', header: true),
        _buildTableRow('1', 'Product Name', '488', '58MAD'),
        _buildTableRow('2', 'Product Name', '445', '198MAD'),
        _buildTableRow('3', 'Product Name', '395', '48MAD'),
        _buildTableRow('4', 'Product Name', '395', '98MAD'),
      ],
    );
  }

  TableRow _buildTableRow(String col1, String col2, String col3, String col4, {bool header = false}) {
    return TableRow(
      children: [
        _buildTableCell(col1, header: header),
        _buildTableCell(col2, header: header),
        _buildTableCell(col3, header: header),
        _buildTableCell(col4, header: header),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool header = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: header ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
