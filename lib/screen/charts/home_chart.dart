// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HomeChart extends StatefulWidget {
  const HomeChart({
    super.key,
    required this.dates,
    required this.listAVG,
    required this.mainAVG,
  });
  final List<String> dates;
  final List<double> listAVG;
  final double mainAVG;

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
            "Weekly analysis",
            style: tt.titleSmall,
          ),
          Text(
            "as ${widget.mainAVG} = 100%",
            style: tt.displaySmall,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              chartElement(
                  ct,
                  widget.listAVG[4] * 2 > 200 ? 200 : widget.listAVG[4] * 2,
                  widget.dates[6]),
              chartElement(
                  ct,
                  widget.listAVG[3] * 2 > 200 ? 200 : widget.listAVG[3] * 2,
                  widget.dates[5]),
              chartElement(
                  ct,
                  widget.listAVG[2] * 2 > 200 ? 200 : widget.listAVG[2] * 2,
                  widget.dates[4]),
              chartElement(
                  ct,
                  widget.listAVG[1] * 2 > 200 ? 200 : widget.listAVG[1] * 2,
                  widget.dates[3]),
              chartElement(
                  ct,
                  widget.listAVG[0] * 2 > 200 ? 200 : widget.listAVG[0] * 2,
                  widget.dates[2]),
              chartElement(
                  ct,
                  widget.listAVG[5] * 2 > 200 ? 200 : widget.listAVG[5] * 2,
                  widget.dates[1]),
              chartElement(
                  ct,
                  widget.listAVG[6] * 2 > 200 ? 200 : widget.listAVG[6] * 2,
                  widget.dates[0]),
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
