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
  List<User> _users = [];
  List<User> _filteredUsers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureUsers = _fetchUsers(); // Fetching users asynchronously
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<User>> _fetchUsers() async {
    final userDao = UserDao(); // Instantiate your DAO
    final users = await userDao
        .getUsers(); // Replace with your actual method to get users
    setState(() {
      _users = users;
      _filteredUsers = users;
    });
    return users;
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user) {
        return user.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showUserDetails(BuildContext context, User user) {
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
                    const SizedBox(height: 20),
                    const Center(
                        child: Icon(
                      Icons.supervised_user_circle_sharp,
                      color: Colors.blueAccent,
                      size: 50,
                    )),
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
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Employees',
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
            child: FutureBuilder<List<User>>(
              future: _futureUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No employees available.'));
                }

                return ListView.builder(
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = _filteredUsers[index];
                    return GestureDetector(
                      onTap: () => _showUserDetails(context, user),
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
                              Icons.supervised_user_circle_sharp,
                              color: Colors.blueAccent,
                              size: 44,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: tt.bodyMedium,
                                ),
                                Text(
                                  user.email,
                                  style: tt.bodySmall,
                                ),
                              ],
                            )
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
