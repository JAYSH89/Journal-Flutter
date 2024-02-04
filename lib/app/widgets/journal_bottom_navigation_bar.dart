import 'package:flutter/material.dart';
import 'package:journal/core/navigation/go_router.dart';

class JournalBottomNavigationBar extends StatelessWidget {
  const JournalBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.routes,
  });

  final int currentIndex;
  final Function(int) onItemTapped;
  final List<Routes> routes;

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        items: _items(),
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
      );

  List<BottomNavigationBarItem> _items() => routes
      .map((e) => BottomNavigationBarItem(
            icon: Icon(e.icon),
            label: e.title,
          ))
      .toList();
}
