import 'package:flutter/material.dart';
import 'package:my_new_app/model/Operation.dart';
import 'package:my_new_app/screen/widget/item_order.dart';

class ListOrders extends StatefulWidget {
  const ListOrders({super.key, required this.allOrders});

  final List<Operation> allOrders;

  @override
  State<ListOrders> createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  TextEditingController _searchController = TextEditingController();
  List<Operation> _filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _filteredOrders = widget.allOrders;
    _searchController.addListener(_filterOrders);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOrders() {
    final query = _searchController.text;
    setState(() {
      _filteredOrders = widget.allOrders.where((order) {
        return order.date.toString().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    ColorScheme ct = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Orders',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search by Date',
                  labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
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
                    _filteredOrders.length > 6 ? 6 : _filteredOrders.length,
                itemBuilder: (context, index) {
                  String dateString = _filteredOrders[index].date.toString();
                  return ItemOrder(
                    n: _filteredOrders[index].id.toString(),
                    totalPrice:
                        "${_filteredOrders[index].TotalPrice.toString()}MAD",
                    date: dateString.substring(0, 19),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
