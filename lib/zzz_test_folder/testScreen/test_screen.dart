import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:signalwavex/zzz_test_folder/testScreen/chart_test/sf_spline_chart.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return SplineDefault(widget.key);
  }
}
