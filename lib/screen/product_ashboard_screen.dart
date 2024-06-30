import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/produit_dao.dart'; // Import your Product DAO
import 'package:my_new_app/model/Produit.dart'; // Import your Product model
import 'package:my_new_app/screen/all_products_screen.dart';

class ProductDashboardScreen extends StatefulWidget {
  const ProductDashboardScreen({Key? key}) : super(key: key);

  @override
  _ProductDashboardScreenState createState() => _ProductDashboardScreenState();
}

class _ProductDashboardScreenState extends State<ProductDashboardScreen> {
  late Future<List<Produit>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ProduitDao().getProduits(); // Initialize data fetch from DAO
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Dashboard'),
        backgroundColor: const Color(0xFF0084FF), // Blue color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Produit>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Show loading spinner
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Show error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found.')); // Show no data message
            } else {
              // Limit the products to the first 4 entries
              List<Produit> limitedProducts = snapshot.data!.take(4).toList();
              return _buildContent(context, limitedProducts, snapshot.data!.length);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Produit> products, int totalProducts) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionCards(),
          const SizedBox(height: 16),
          const Text(
            'Your Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildProductTable(products),
          const SizedBox(height: 10),
          _buildFooterActions(context, totalProducts),
          const SizedBox(height: 20),
          _buildAdditionalCards(),
        ],
      ),
    );
  }

  Widget _buildActionCards() {
    return const Row(
      children: [
        Expanded(
          child: Card(
            color: Color(0xFF0084FF),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'From 85 Product Provider',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Card(
            color: Color(0xFFD0D8FF),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Providers',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'You Have 85 Product Providers',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductTable(List<Produit> products) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FixedColumnWidth(40),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(100),
        3: FixedColumnWidth(100),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Color(0xFF0084FF)),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'N.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Name',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Quantity',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Price',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...products.asMap().entries.map((entry) {
          int index = entry.key;
          Produit product = entry.value;
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text((index + 1).toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.name),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.quantite.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${product.PrixVente.toStringAsFixed(2)} MAD'),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildFooterActions(BuildContext context, int totalProducts) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('$totalProducts other products'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0084FF),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AllProductScreen()),
            );
          },
          child: const Text('See All'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0084FF),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalCards() {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                color: Color(0xFF0084FF),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manage',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Manage your Products',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Card(
                color: Color(0xFFD0D8FF),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discounts',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Make some offers on your Products',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Card(
          color: Color(0xFF00FFFF),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Products Analysis',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See All the Analysis of your products',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
