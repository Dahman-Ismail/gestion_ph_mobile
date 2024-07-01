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
  List<Produit> _allProducts = [];
  List<Produit> _filteredProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureProducts = _fetchProducts();
    _searchController.addListener(_filterProducts);
  }

  Future<List<Produit>> _fetchProducts() async {
    final productDao = ProduitDao();
    final products = await productDao.getProduits();
    setState(() {
      _allProducts = products;
      _filteredProducts = products;
    });
    return products;
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showProductDetails(BuildContext context, Produit product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
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
                    const Center(
                      child: Icon(
                        Icons.inventory,
                        color: Colors.blueAccent,
                        size: 50,
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Products',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search by Name',
                  labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Produit>>(
              future: _futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                return ListView.builder(
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    return InkWell(
                      onTap: () => _showProductDetails(context, product),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.inventory_2,
                              color: Colors.blueAccent,
                              size: 34,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name),
                                Text(
                                    '\$${product.PrixVente.toStringAsFixed(2)}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
