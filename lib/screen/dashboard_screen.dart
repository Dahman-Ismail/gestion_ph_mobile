import 'package:flutter/material.dart';
import 'package:my_new_app/screen/all_products_screen.dart';
// import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Sales",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'MAD 25,400',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Yesterday sales: 44,569MAD',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'This Week',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 10),
            // Container(
            //   height: 200,
            //   child: BarChart(
            //     BarChartData(
            //       barGroups: [
            //         BarChartGroupData(x: 0, barRods: [
            //           BarChartRodData(y: 8, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //         ]),
            //         BarChartGroupData(x: 1, barRods: [
            //           BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //         ]),
            //         BarChartGroupData(x: 2, barRods: [
            //           BarChartRodData(y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //         ]),
            //         BarChartGroupData(x: 3, barRods: [
            //           BarChartRodData(y: 15, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //         ]),
            //         BarChartGroupData(x: 4, barRods: [
            //           BarChartRodData(y: 13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //         ]),
            //         BarChartGroupData(x: 5, barRods: [
            //           BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //         ]),
            //         BarChartGroupData(x: 6, barRods: [
            //           BarChartRodData(y: 12, colors: [Colors.lightBlueAccent, Colors.greenAccent])
            //         ]),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Top Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllProductScreen()),
                    );
                  },
                  child: const Text('See All'),
                ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Text('1'),
                    title: Text('Product Name'),
                    trailing: Text('488'),
                    
                    
                    
                  ),
                  ListTile(
                    leading: Text('2'),
                    title: Text('Product Name'),
                    trailing: Text('445'),
                  ),
                  ListTile(
                    leading: Text('3'),
                    title: Text('Product Name'),
                    trailing: Text('395'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      //   ],
      // ),
    );
  }
}
