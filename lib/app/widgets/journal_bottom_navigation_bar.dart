import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:journal/core/navigation/go_router.dart';

class JournalMaterialTabBar extends StatelessWidget {
  const JournalMaterialTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.routes,
  });

  final int currentIndex;
  final Function(int) onTap;
  final List<Routes> routes;

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        items: _items(),
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
      );

  List<BottomNavigationBarItem> _items() => routes
      .map((route) => BottomNavigationBarItem(
            icon: Icon(route.materialIcon),
            label: route.title,
          ))
      .toList();
}

class JournalCupertinoTabBar extends CupertinoTabBar {
  final List<Routes> routes;

  JournalCupertinoTabBar({
    super.key,
    required super.onTap,
    required super.currentIndex,
    required this.routes,
  }) : super(
          items: routes.map((route) {
            return BottomNavigationBarItem(
              icon: Icon(route.cupertinoIcon),
              label: route.title,
            );
          }).toList(),
        );
}
