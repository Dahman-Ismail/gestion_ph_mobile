import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/Fournisseur_dao.dart';
import 'package:my_new_app/model/Fournisseur.dart'; // Replace with the correct path to your Fournisseur model

class AllSupplierScreen extends StatefulWidget {
  const AllSupplierScreen({super.key});

  @override
  State<AllSupplierScreen> createState() => _AllSupplierScreenState();
}

class _AllSupplierScreenState extends State<AllSupplierScreen> {
  late Future<List<Fournisseur>> _futureFournisseurs;

  @override
  void initState() {
    super.initState();
    _futureFournisseurs = _fetchFournisseurs(); // Fetching suppliers asynchronously
  }

  Future<List<Fournisseur>> _fetchFournisseurs() async {
    final fournisseurDao = FournisseurDao(); // Instantiate your DAO
    return await fournisseurDao.getFournisseurs(); // Replace with your actual method to get suppliers
  }

  void _showFournisseurDetails(BuildContext context, Fournisseur fournisseur) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to be full-screen if needed
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // Initial height as a fraction of screen height
          minChildSize: 0.3, // Minimum height as a fraction of screen height
          maxChildSize: 0.8, // Maximum height as a fraction of screen height
          expand: false, // Do not expand to full screen initially
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController, // Allows for scrolling inside the bottom sheet
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
                    const SizedBox(height: 20),
                    // Optionally add an image if available
                    Center(
                      child: Image.network(
                        'https://via.placeholder.com/150', // Placeholder image URL
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      fournisseur.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Telephone: ${fournisseur.telephone}'),
                    Text('Email: ${fournisseur.email}'),
                    Text('Pays: ${fournisseur.pays}'),
                    Text('Ville: ${fournisseur.ville}'),
                    Text('Adresse: ${fournisseur.adresse}'),
                    const SizedBox(height: 15),
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
        title: const Text('All Suppliers'),
      ),
      body: FutureBuilder<List<Fournisseur>>(
        future: _futureFournisseurs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No suppliers available.'));
          }
          final fournisseurs = snapshot.data!;
          return ListView.builder(
            itemCount: fournisseurs.length,
            itemBuilder: (context, index) {
              final fournisseur = fournisseurs[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/50'), // Placeholder image URL
                  radius: 25,
                ),
                title: Text(fournisseur.name),
                subtitle: Text(fournisseur.email),
                onTap: () => _showFournisseurDetails(context, fournisseur),
              );
            },
          );
        },
      ),
    );
  }
}
