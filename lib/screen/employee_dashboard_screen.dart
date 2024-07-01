import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/user_dao.dart';
import 'package:my_new_app/model/Users.dart';
import 'package:my_new_app/screen/all_mployee_screen.dart';
import 'package:my_new_app/screen/home_screen.dart';
import 'package:my_new_app/screen/widget/item_emp.dart';
import 'package:my_new_app/service/loginservice.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = UserDao().getUsers(); // Initialize data fetch
  }

  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee Dashboard',
          style: tt.headlineLarge,
        ),
        backgroundColor: const Color(0xFF0084FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<User>>(
          future: _usersFuture,
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
                  child: Text('No users found.')); // Show no data message
            } else {
              // Limit the users to the first 4 entries
              List<User> limitedUsers = snapshot.data!.toList();
              return _buildContent(context, limitedUsers);
            }
          },
        ),
      ),
    );
  }

  bool isReload = false;

  Widget _buildContent(BuildContext context, List<User> users) {
    TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMessagesCard(context, users.length),
              const SizedBox(height: 20),
              Text(
                'Your Employees',
                style: tt.labelSmall,
              ),
              const SizedBox(height: 10),
              _buildEmployee(users, context),
              const SizedBox(height: 10),
              _buildFooterActions(context, users.length),
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
                                page: 2,
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
        ],
      ),
    );
  }

  Widget _buildEmployee(List<User> users, BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    ColorScheme ct = Theme.of(context).colorScheme;
    Size mq = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
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
                width: mq.width * 0.26,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Name",
                    style: tt.labelLarge,
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Role",
                    style: tt.labelLarge,
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * 0.36,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Email",
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
          itemCount: users.length > 6 ? 6 : users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return ItemEmp(
              n: (index + 1).toString(),
              name: user.name,
              role: user.roleId == 1 ? 'Admin' : 'Employee',
              email: user.email,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFooterActions(BuildContext context, int userCount) {
    ColorScheme ct = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ct.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Text(
              "$userCount total users",
              style: tt.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesCard(BuildContext context, int users) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllEmployeeScreen()),
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
                      'See All Users',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See all information about the $users user",
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
}
