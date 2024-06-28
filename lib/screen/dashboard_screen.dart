import 'package:flutter/material.dart';
import 'package:my_new_app/screen/charts/home_chart.dart';
import 'package:my_new_app/screen/widget/item_disp.dart';
// import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List itemsList = [
    ["1", "Name 1", "546", "165MAD"],
    ["2", "Name 2", "406", "631MAD"],
    ["3", "Name 3", "67", "947MAD"],
    ["3", "Name 3", "67", "947MAD"],
    ["3", "Name 3", "67", "947MAD"],
    ["4", "Name 4", "406", "141MAD"]
  ];
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    ColorScheme ct = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: ct.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: mq.width * 0.84,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today's Sales",
                                style: tt.labelLarge,
                              ),
                              Text(
                                'MAD 25,400',
                                style: tt.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Text(
                                    'Yesterday sales: ',
                                    style: TextStyle(
                                      color: Colors.tealAccent,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "44,569MAD",
                                    style: tt.labelLarge,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Margin: ',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "-0.46%",
                                    style: tt.labelLarge,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'This Week',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const HomeChart(),
                    const SizedBox(height: 20),
                    const Text(
                      'This Week',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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
                            width: mq.width * 0.38,
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
                            width: mq.width * 0.28,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                "Total",
                                style: tt.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: mq.width,
                      height: mq.height * 0.38,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: itemsList.length,
                        itemBuilder: (context, index) {
                          return ItemDisp(
                            n: itemsList[index][0],
                            name: itemsList[index][1],
                            quantity: itemsList[index][2],
                            total: itemsList[index][3],
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {}, // Call _logout function
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                        ),
                        backgroundColor: WidgetStateProperty.all(ct.primary),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: ct.surface,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              "See More",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
        ));
  }
}
