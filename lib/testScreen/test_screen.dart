import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signalwavex/Features/current_order_page.dart';
import 'package:signalwavex/feed/feed.dart';
import 'package:signalwavex/testScreen/candle_stick_chart.dart';
import 'package:signalwavex/testScreen/k_chart_sample.dart';
import 'package:signalwavex/testScreen/line_chart.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: KChartSample(),
        // child: LineChart(),
        // child: CandleStickChart(),
        child: CurrentOrderPage(),
      ),
    );
  }
}
