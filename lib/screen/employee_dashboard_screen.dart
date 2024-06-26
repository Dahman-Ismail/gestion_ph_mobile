import 'package:flutter/material.dart';
import 'package:my_new_app/screen/all_mployee_screen.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
        backgroundColor: Color(0xFF0084FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
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
                                color: Colors.white,
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
              ),
              const SizedBox(height: 16),
              const Text(
                'Your Employs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Table(
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
                  ...List.generate(4, (index) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text((index + 1).toString()),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('User Name'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Employ'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('2:30h'),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('120 other user'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0084FF),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllEmployeeScreen()),
                    );
                    },
                    child: const Text('See All'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0084FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
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
                              'Contact your Employs on the app',
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
              ),
              const SizedBox(height: 20),
              const Card(
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
                        'See All the Analysis of your products',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
