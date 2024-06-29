import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/user_dao.dart';
import 'package:my_new_app/model/Users.dart';
import 'package:my_new_app/screen/all_mployee_screen.dart'; 

class EmployeeDashboardScreen extends StatefulWidget {
  
  const EmployeeDashboardScreen({Key? key}) : super(key: key);

  @override
  _EmployeeDashboardScreenState createState() => _EmployeeDashboardScreenState();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
        backgroundColor: const Color(0xFF0084FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<User>>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Show loading spinner
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Show error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No users found.')); // Show no data message
            } else {
              // Limit the users to the first 4 entries
              List<User> limitedUsers = snapshot.data!.take(4).toList();
              return _buildContent(context, limitedUsers);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<User> users) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionCards(),
          const SizedBox(height: 16),
          const Text(
            'Your Employees',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildEmployeeTable(users),
          const SizedBox(height: 10),
          _buildFooterActions(context),
          const SizedBox(height: 20),
          _buildMessagesCard(),
          const SizedBox(height: 20),
          _buildAnalysisCard(),
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
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Add New User',
                    style: TextStyle(
                      color: Color.fromARGB(255, 243, 243, 243),
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
                    'Manage',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Manage your Users',
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

  Widget _buildEmployeeTable(List<User> users) {
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
                'Role',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Hours',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...users.asMap().entries.map((entry) {
          int index = entry.key;
          User user = entry.value;
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text((index + 1).toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.name),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Employee'), // Role could be dynamic if available
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('2:30h'), // Placeholder for hours, replace with actual data if available
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildFooterActions(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            '120 other users',
            style: TextStyle(
              color: Color.fromARGB(255, 252, 252, 252),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0084FF),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllEmployeeScreen()),
            );
          },
          child: const Text(
            'See All',
            style: TextStyle(
              color: Color.fromARGB(255, 252, 252, 252),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0084FF),
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesCard() {
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
                    'Messages',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Contact your Employees on the app',
                    style: TextStyle(
                      color: Colors.white,
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

  Widget _buildAnalysisCard() {
    return const Card(
      color: Color(0xFF00FFFF),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provider Analysis',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'See all the analysis of your products',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
