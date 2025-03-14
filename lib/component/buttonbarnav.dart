import 'package:flutter/material.dart';
import 'package:signalwavex/component/color.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Map<String, String>> navItems = [
    {
      'icon': 'assets/icons/home.png',
      'label': 'Home',
    },
    {'icon': 'assets/icons/line.png', 'label': 'Market'},
    {'icon': 'assets/icons/chat.png', 'label': 'Features'},
    {'icon': 'assets/icons/graphup.png', 'label': 'Perpetual'},
    {'icon': 'assets/icons/money.png', 'label': 'Assets'},
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: navItems.map((item) {
        return BottomNavigationBarItem(
          icon: Image.asset(
            item['icon']!,
            fit: BoxFit.cover,
            width: 24,
            height: 24,
            color: widget.selectedIndex == navItems.indexOf(item)
                ? ColorConstants.numyelcolor
                : Colors.white,
          ),
          label: item['label'],
        );
      }).toList(),
      selectedItemColor: ColorConstants.numyelcolor,
      unselectedItemColor: Colors.white,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
    );
  }
}
