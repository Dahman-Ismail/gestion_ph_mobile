import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_new_app/db/DAO/operation_dao.dart';
import 'package:my_new_app/model/Operation.dart';
import 'package:my_new_app/screen/charts/home_chart.dart';
import 'package:my_new_app/screen/home_screen.dart';
import 'package:my_new_app/screen/list_orders.dart';
import 'package:my_new_app/screen/widget/item_order.dart';
import 'package:my_new_app/service/loginservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future getOrders() async {}
  List<Operation> _allOrders = [];
  List<String> dates = ["", "", "", "", "", "", ""];
  // ignore: prefer_final_fields
  List<double> _pastDaysTotals = List.filled(7, 1.0);
  List<double> listAvg = [0, 0, 0, 0, 0, 0, 0];
  double mainAvg = 10000;

  void _calculateTotalsForDay(
      DateTime targetDay, List<Operation> targetList, double targetTotal) {
    for (var order in _allOrders) {
      DateTime orderDate = DateTime.parse(order.date);
      DateTime orderDateOnly =
          DateTime(orderDate.year, orderDate.month, orderDate.day);

      if (orderDateOnly == targetDay) {
        targetList.add(order);
        targetTotal += order.TotalPrice;
      }
    }
  }

  List itemsList = [
    ["1", "Name 1", "546", "165MAD"],
    ["2", "Name 2", "406", "631MAD"],
    ["3", "Name 3", "67", "947MAD"],
    ["3", "Name 3", "67", "947MAD"],
    ["3", "Name 3", "67", "947MAD"],
    ["4", "Name 4", "406", "141MAD"]
  ];
  final List<Operation> _todayOrders = [];
  final List<Operation> _yesterdayOrders = [];
  double _todaySalesTotal = 0.0;
  double _yesterdaySalesTotal = 0.0;
  double _margin = 0.0;

  void _getPreviousDays() {
    List<String> previousDays = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime previousDate = now.subtract(Duration(days: i));
      String formattedDate =
          '${previousDate.day.toString().padLeft(2, '0')}/${previousDate.month.toString().padLeft(2, '0')}';
      previousDays.add(formattedDate);
    }

    setState(() {
      dates = previousDays;
    });
  }

  Future<void> _fetchOrders() async {
    final operationDao = OperationDao();
    final orders = await operationDao
        .getOperations(); // Adjust this to fetch operations from your DAO
    setState(() {
      _allOrders = orders;
      _filterOrders();
    });
  }

  void _filterOrders() {
    // Get today and yesterday's dates
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    // Clear previous lists and initialize totals
    _todayOrders.clear();
    _yesterdayOrders.clear();
    double todayTotal = 0;
    double yesterdayTotal = 0;

    // Filter orders into today's and yesterday's lists and calculate totals
    for (var order in _allOrders) {
      DateTime orderDate = DateTime.parse(order.date);
      DateTime orderDateOnly =
          DateTime(orderDate.year, orderDate.month, orderDate.day);

      if (orderDateOnly == today) {
        _todayOrders.add(order);
        todayTotal += order.TotalPrice;
      } else if (orderDateOnly == yesterday) {
        _yesterdayOrders.add(order);
        yesterdayTotal += order.TotalPrice;
      }
    }

    // Calculate totals for past 5 days
    _pastDaysTotals.fillRange(0, 5, 0.0); // Reset previous totals
    for (int i = 0; i < 5; i++) {
      DateTime pastDay =
          today.subtract(Duration(days: i + 2)); // Start from 2 days ago
      _calculateTotalsForDay(pastDay, [],
          _pastDaysTotals[i]); // Empty list as we're only interested in totals
    }

    // Update UI with calculated totals
    setState(() {
      _todaySalesTotal = todayTotal;
      _yesterdaySalesTotal = yesterdayTotal;

      // Calculate percentage margin
      if (_yesterdaySalesTotal != 0) {
        _margin =
            ((_todaySalesTotal - _yesterdaySalesTotal) / _yesterdaySalesTotal) *
                100;
      } else {
        _margin = 100; // Handle division by zero scenario
      }
      _pastDaysTotals[5] = _yesterdaySalesTotal;
      _pastDaysTotals[6] = _todaySalesTotal;
      _getAVG();
    });
  }

  void _getAVG() {
    List<double> datal = [0, 0, 0, 0, 0, 0, 0];
    for (var i = 0; i < 7; i++) {
      datal[i] = (_pastDaysTotals[i] * 100) / mainAvg;
    }
    setState(() {
      listAvg = datal;
    });
  }
  //3456721

  // void _filterOrders() {
  //   // Get today and yesterday's dates
  //   DateTime now = DateTime.now();
  //   DateTime today = DateTime(now.year, now.month, now.day);
  //   DateTime yesterday = today.subtract(const Duration(days: 1));

  //   // Clear previous lists
  //   _todayOrders.clear();
  //   _yesterdayOrders.clear();

  //   // Filter orders into today's and yesterday's lists
  //   for (var order in _allOrders) {
  //     DateTime orderDate = DateTime.parse(order.date);
  //     DateTime orderDateOnly =
  //         DateTime(orderDate.year, orderDate.month, orderDate.day);

  //     if (orderDateOnly == today) {
  //       _todayOrders.add(order);
  //     } else if (orderDateOnly == yesterday) {
  //       _yesterdayOrders.add(order);
  //     }
  //   }
  // }
  bool isReload = false;
  Future<double?> _getStoredDouble() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('storedDouble');
  }

  Future<void> _loadStoredDouble() async {
    final double? storedDouble = await _getStoredDouble();
    setState(() {
      mainAvg = storedDouble ?? 10000;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders();
    _getPreviousDays();
    _loadStoredDouble();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    ColorScheme ct = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        floatingActionButton: FloatingActionButton(
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
                        page: 0,
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
                                'MAD ${_todaySalesTotal.toString()}',
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
                                    "${_yesterdaySalesTotal.toString()}MAD",
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
                                    "$_margin%",
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
                    HomeChart(
                      dates: dates,
                      listAVG: listAvg,
                      mainAVG: mainAvg,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All Orders',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListOrders(
                                        allOrders: _allOrders,
                                      )),
                            );
                          }, // Call _logout function
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                            ),
                            backgroundColor:
                                WidgetStateProperty.all(ct.primary),
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
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                            width: mq.width * 0.30,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                "Total Price",
                                style: tt.labelLarge,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mq.width * 0.34,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                "Date",
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
                        itemCount:
                            _allOrders.length > 6 ? 6 : _allOrders.length,
                        itemBuilder: (context, index) {
                          String dateString = _allOrders[index].date.toString();
                          return ItemOrder(
                            n: _allOrders[index].id.toString(),
                            totalPrice:
                                "${_allOrders[index].TotalPrice.toString()}MAD",
                            date: dateString.substring(0, 19),
                          );
                        },
                      ),
                    ),
                  ])),
        ));
  }
}
