import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/user_dao.dart'; // Import your DAO here
import 'package:my_new_app/model/Users.dart'; // Replace with the correct path to your User model

class AllEmployeeScreen extends StatefulWidget {
  const AllEmployeeScreen({super.key});

  @override
  State<AllEmployeeScreen> createState() => _AllEmployeeScreenState();
}

class _AllEmployeeScreenState extends State<AllEmployeeScreen> {
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = _fetchUsers(); // Fetching users asynchronously
  }

  Future<List<User>> _fetchUsers() async {
    final userDao = UserDao(); // Instantiate your DAO
    return await userDao.getUsers(); // Replace with your actual method to get users
  }

  void _showUserDetails(BuildContext context, User user) {
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
                    Center(
                      child: Image.network(
                        'https://via.placeholder.com/150', // Placeholder image URL
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Email: ${user.email}'),
                    if (user.emailVerifiedAt != null)
                      Text('Email Verified At: ${user.emailVerifiedAt}'),
                    Text('Role ID: ${user.roleId}'),
                    if (user.rememberToken != null)
                      Text('Remember Token: ${user.rememberToken}'),
                    if (user.createdAt != null)
                      Text('Created At: ${user.createdAt}'),
                    if (user.updatedAt != null)
                      Text('Updated At: ${user.updatedAt}'),
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
        title: const Text('All Employees'),
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No employees available.'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/50'), // Placeholder image URL
                  radius: 25,
                ),
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () => _showUserDetails(context, user),
              );
            },
          );
        },
      ),
    );
  }
}
