import 'package:flutter/material.dart';
import 'package:signalwavex/component/buttonbarnav.dart';
import 'package:signalwavex/feed/homepage.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _indexSelection = 0;
  List<Widget> _pages = [
    Homepage(),
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.indigoAccent,
    ),
    Container(
      color: Colors.redAccent,
    ),
    Container(
      color: Colors.pink,
    ),
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
