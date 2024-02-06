import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:journal/core/navigation/go_router.dart';

typedef TabRoute = ({Routes route, Widget page});

class JournalMaterialTabBar extends StatelessWidget {
  const JournalMaterialTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.routes,
  });

  final int currentIndex;
  final Function(int) onTap;
  final List<TabRoute> routes;

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        items: _items(),
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
      );

  List<BottomNavigationBarItem> _items() => routes
      .map((tabRoute) => BottomNavigationBarItem(
            icon: Icon(tabRoute.route.materialIcon),
            label: tabRoute.route.title,
          ))
      .toList();
}

class JournalCupertinoTabBar extends CupertinoTabBar {
  final List<TabRoute> routes;

  JournalCupertinoTabBar({
    super.key,
    required super.onTap,
    required super.currentIndex,
    required this.routes,
  }) : super(
          items: routes.map((e) {
            return BottomNavigationBarItem(
              icon: Icon(e.route.cupertinoIcon),
              label: e.route.title,
            );
          }).toList(),
        );
}
