import 'package:flutter/material.dart';
import 'package:signalwavex/feed/Features/current_order_page.dart';
import 'package:signalwavex/component/buttonbarnav.dart';
import 'package:signalwavex/feed/asset.dart';
import 'package:signalwavex/feed/homepage.dart';
import 'package:signalwavex/feed/market.dart';
import 'package:signalwavex/feed/ppertual.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _indexSelection = 0;
  final List<Widget> _pages = [
    const Homepage(),
    const Market(),
    const FeaturesCurrentOrder(),
    const PerpetualScreen(),
    const Assets()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: IndexedStack(
        index: _indexSelection,
        children: _pages,
      )),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavBar(
        selectedIndex: _indexSelection,
        onItemTapped: (index) {
          setState(() {
            _indexSelection = index;
          });
        });
  }
}
