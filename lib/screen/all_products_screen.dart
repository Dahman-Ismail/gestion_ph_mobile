import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 50, // Assuming there are 50 products for the example
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text('${index + 1}'),
              title: Text('Product Name ${index + 1}'),
              trailing: Text('${(index + 1) * 10}MAD'),
            ),
          );
        },
      ),
    );
  }
}
