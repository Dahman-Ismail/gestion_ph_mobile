// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HomeChart extends StatefulWidget {
  const HomeChart({super.key});

  @override
  State<HomeChart> createState() => _HomeChartState();
}

class _HomeChartState extends State<HomeChart> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    ColorScheme ct = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      height: mq.height * 0.38,
      width: mq.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: ct.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "+ 3.5%",
            style: tt.titleSmall,
          ),
          Text(
            "Compared to the last week",
            style: tt.displaySmall,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              chartElement(ct, 124, "Mon"),
              chartElement(ct, 189, "Tus"),
              chartElement(ct, 89, "Wed"),
              chartElement(ct, 102, "Thu"),
              chartElement(ct, 178, "Fri"),
              chartElement(ct, 100, "Sat"),
              chartElement(ct, 10, "Sun"),
            ],
          )
        ],
      ),
    );
  }

  Column chartElement(ColorScheme ct, double val, String day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 200,
              width: 34,
              decoration: BoxDecoration(
                  color: ct.background, borderRadius: BorderRadius.circular(6)),
            ),
            Container(
              height: val,
              width: 34,
              decoration: BoxDecoration(
                  color: ct.secondary, borderRadius: BorderRadius.circular(6)),
            )
          ],
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: TextStyle(
              color: ct.onSurface, fontWeight: FontWeight.w600, fontSize: 10),
        )
      ],
    );
  }
}
