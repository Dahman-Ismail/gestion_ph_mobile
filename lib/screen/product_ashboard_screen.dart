import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/produit_dao.dart'; // Import your Product DAO
import 'package:my_new_app/model/Produit.dart'; // Import your Product model
import 'package:my_new_app/screen/all_products_screen.dart';
import 'package:my_new_app/screen/home_screen.dart';
import 'package:my_new_app/screen/widget/item_disp.dart';
import 'package:my_new_app/service/loginservice.dart';

class ProductDashboardScreen extends StatefulWidget {
  const ProductDashboardScreen({super.key});

  @override
  State<ProductDashboardScreen> createState() => _ProductDashboardScreenState();
}

class _ProductDashboardScreenState extends State<ProductDashboardScreen> {
  late Future<List<Produit>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture =
        ProduitDao().getProduits(); // Initialize data fetch from DAO
  }

  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products Dashboard',
          style: tt.headlineLarge,
        ),
        backgroundColor: const Color(0xFF0084FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Produit>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator()); // Show loading spinner
            } else if (snapshot.hasError) {
              return Center(
                  child:
                      Text('Error: ${snapshot.error}')); // Show error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('No products found.')); // Show no data message
            } else {
              // Limit the products to the first 4 entries
              List<Produit> limitedProducts = snapshot.data!.toList();
              return _buildContent(
                  context, limitedProducts, snapshot.data!.length);
            }
          },
        ),
      ),
    );
  }

  bool isReload = false;

  Widget _buildContent(
      BuildContext context, List<Produit> products, int totalProducts) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildActionCards(),
          _buildMessagesCard(context, products.length),
          const SizedBox(height: 16),
          const Text(
            'Your Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildProduct(products, context),
          const SizedBox(height: 10),
          _buildFooterActions(context, totalProducts),
          const SizedBox(height: 20),
          const SizedBox(height: 28),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                setState(() {
                  isReload = true;
                });
                LoginService refresh = LoginService();
                await refresh.loginAndFetchData();
                setState(() {
                  isReload = false;
                });
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            page: 1,
                          )),
                );
              },
              child: isReload
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 34,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesCard(BuildContext context, int products) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllProductScreen()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF0084FF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'See All Products',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See all info about the $products product",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildActionCards() {
  //   return const Row(
  //     children: [
  //       Expanded(
  //         child: Card(
  //           color: Color(0xFF0084FF),
  //           child: Padding(
  //             padding: EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Order',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(
  //                   'From 85 Product Provider',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(width: 16),
  //       Expanded(
  //         child: Card(
  //           color: Color(0xFFD0D8FF),
  //           child: Padding(
  //             padding: EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Providers',
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(
  //                   'You Have 85 Product Providers',
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildProduct(List<Produit> products, BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    ColorScheme ct = Theme.of(context).colorScheme;
    Size mq = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          // margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: ct.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ct.onSurface.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: mq.width * 0.08,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "N.",
                    style: tt.labelLarge,
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * 0.30,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Name",
                    style: tt.labelLarge,
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * 0.18,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Quantity",
                    style: tt.labelLarge,
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * 0.36,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Price",
                    style: tt.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length > 6 ? 6 : products.length,
          itemBuilder: (context, index) {
            Produit product = products[index];
            return ItemDisp(
              n: (index + 1).toString(),
              name: product.name,
              quantity: product.quantite.toString(),
              price: "${product.PrixVente.toString()}MAD",
            );
          },
        ),
      ],
    );
  }

  // Widget _buildProductTable(List<Produit> products) {
  //   return Table(
  //     border: TableBorder.all(color: Colors.grey),
  //     columnWidths: const {
  //       0: FixedColumnWidth(40),
  //       1: FlexColumnWidth(),
  //       2: FixedColumnWidth(100),
  //       3: FixedColumnWidth(100),
  //     },
  //     children: [
  //       const TableRow(
  //         decoration: BoxDecoration(color: Color(0xFF0084FF)),
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Text(
  //               'N.',
  //               style:
  //                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Text(
  //               'Name',
  //               style:
  //                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Text(
  //               'Quantity',
  //               style:
  //                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Text(
  //               'Price',
  //               style:
  //                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         ],
  //       ),
  //       ...products.asMap().entries.map((entry) {
  //         int index = entry.key;
  //         Produit product = entry.value;
  //         return TableRow(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text((index + 1).toString()),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(product.name),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text(product.quantite.toString()),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text('${product.PrixVente.toStringAsFixed(2)} MAD'),
  //             ),
  //           ],
  //         );
  //       }).toList(),
  //     ],
  //   );
  // }

  Widget _buildFooterActions(BuildContext context, int totalProducts) {
    ColorScheme ct = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ct.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Text(
          '$totalProducts Total products',
          style: tt.bodyLarge,
        ),
      ),
    );
  }

//   Widget _buildAdditionalCards() {
//     return const Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Card(
//                 color: Color(0xFF0084FF),
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Manage',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Manage your Products',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: Card(
//                 color: Color(0xFFD0D8FF),
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Discounts',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Make some offers on your Products',
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         Card(
//           color: Color(0xFF00FFFF),
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Products Analysis',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'See All the Analysis of your products',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
}
