// lib/all_product_screen.dart
import 'package:flutter/material.dart';
import 'package:my_new_app/model/Produit.dart';
// import 'produit.dart';

class AllProductScreen extends StatelessWidget {
  // Generating a list of fake products
  final List<Produit> products = List.generate(
    10,
    (index) => Produit(
      id: index,
      fournisseurId: 101 + index,
      image: 'https://via.placeholder.com/150', // Placeholder image URL
      name: 'Product $index',
      barCode: 100000 + index,
      quantite: 50 + index,
      price: 20.0 + index * 2,
      discount: 10 + index,
      categoryId: 5 + index,
      description: 'Description for product $index. This is an excellent product that meets your needs.',
      expirrationDate: '2024-12-${10 + index}',
      quantitePiece: 20,
    ),
  );

  // Method to show product details in a bottom sheet
  void _showProductDetails(BuildContext context, Produit product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.image,
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(product.description),
              SizedBox(height: 8),
              Text(
                'Price: \$${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Barcode: ${product.barCode}'),
              Text('Quantity: ${product.quantite}'),
              Text('Discount: ${product.discount}%'),
              Text('Category ID: ${product.categoryId}'),
              Text('Expiration Date: ${product.expirrationDate}'),
              Text('quantitePiece is: ${product.quantitePiece}'),
              
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            onTap: () => _showProductDetails(context, product),
          );
        },
      ),
    );
  }
}
