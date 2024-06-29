import 'package:flutter/material.dart'; // Import your DAO here
import 'package:my_new_app/db/DAO/produit_dao.dart';
import 'package:my_new_app/model/Produit.dart'; // Replace with the correct path to your Produit model

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  late Future<List<Produit>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = _fetchProducts(); // Fetching products asynchronously
  }

  Future<List<Produit>> _fetchProducts() async {
    final productDao = ProduitDao(); // Instantiate your DAO
    return await productDao
        .getProduits(); // Replace with your actual method to get products
  }

  void _showProductDetails(BuildContext context, Produit product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the bottom sheet to be full-screen if needed
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize:
              0.5, // Initial height as a fraction of screen height
          minChildSize: 0.3, // Minimum height as a fraction of screen height
          maxChildSize: 0.8, // Maximum height as a fraction of screen height
          expand: false, // Do not expand to full screen initially
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller:
                  scrollController, // Allows for scrolling inside the bottom sheet
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Card(
                        color: Color.fromARGB(255, 45, 50, 55),
                        child: SizedBox(
                          width: 70.0,
                          height: 6.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Image.network(
                        product.image,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(product.description),
                    const SizedBox(height: 8),
                    Text(
                      'Price: \$${product.PrixVente.toStringAsFixed(2)}',
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('id: ${product.id}'),
                    Text('fournisseurId: ${product.fournisseurId}'),
                    Text('image: ${product.image}'),
                    Text('prix: ${product.PrixAchat}'),
                    Text('Barcode: ${product.barCode}'),
                    Text('Quantity: ${product.quantite}'),
                    Text('Discount: ${product.discount}%'),
                    Text('Category ID: ${product.categoryId}'),
                    Text('Expiration Date: ${product.expirationDate}'),
                    Text('Quantité par pièce: ${product.quantitePiece}'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: FutureBuilder<List<Produit>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          final products = snapshot.data!;
          return ListView.builder(
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
                subtitle: Text('\$${product.PrixVente.toStringAsFixed(2)}'),
                onTap: () => _showProductDetails(context, product),
              );
            },
          );
        },
      ),
    );
  }
}
