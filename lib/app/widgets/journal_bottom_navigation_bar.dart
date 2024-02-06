import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:journal/core/navigation/go_router.dart';

typedef TabRoute = ({Routes route, Widget page});

class JournalBottomNavigationBar extends StatelessWidget {
  const JournalBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.routes,
  });

  final int currentIndex;
  final Function(int) onItemTapped;
  final List<TabRoute> routes;

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(useMaterial3: false),
        child: BottomNavigationBar(
          items: _items(),
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
        ),
      );

  List<BottomNavigationBarItem> _items() => routes
      .map((tabRoute) => BottomNavigationBarItem(
            icon: Icon(tabRoute.route.materialIcon),
            label: tabRoute.route.title,
          ))
      .toList();
}

class JournalCupertinoBottomNavigationBar extends CupertinoTabBar {
  final List<TabRoute> routes;
  final Function(int) onTabBarItemTapped;

  JournalCupertinoBottomNavigationBar({
    super.key,
    required this.routes,
    required this.onTabBarItemTapped,
  }) : super(
          onTap: onTabBarItemTapped,
          items: routes.map((e) {
            return BottomNavigationBarItem(
              icon: Icon(e.route.cupertinoIcon),
              label: e.route.title,
            );
          }).toList(),
        );
}
