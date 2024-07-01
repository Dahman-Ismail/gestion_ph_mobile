import 'package:flutter/material.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    required this.n,
    required this.totalPrice,
    required this.date,
    super.key,
  });
  final String n;
  final String totalPrice;
  final String date;

  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    ColorScheme ct = Theme.of(context).colorScheme;
    Size mq = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: ct.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: ct.onSurface.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 4))
          ]),
      child: Row(
        children: [
          SizedBox(
            width: mq.width * 0.08,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                n,
                style: tt.bodySmall,
              ),
            ),
          ),
          SizedBox(
            width: mq.width * 0.30,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                totalPrice,
                style: tt.bodySmall,
              ),
            ),
          ),
          SizedBox(
            width: mq.width * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                date,
                style: tt.bodySmall,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
