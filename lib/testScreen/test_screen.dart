import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signalwavex/component/drawer_component.dart';
import 'package:signalwavex/feed/Features-UI/current_order_page.dart';

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
        child: drawerComponent(context),
      ),
    );
  }
}
