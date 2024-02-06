import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/journal_bottom_navigation_bar.dart';

class JournalMaterialScaffold extends Scaffold {
  final List<TabRoute> routes;
  final StatefulNavigationShell navigationShell;
  final Function(int) onTap;

  JournalMaterialScaffold({
    super.key,
    required this.routes,
    required this.navigationShell,
    required this.onTap,
  }) : super(
          bottomNavigationBar: JournalMaterialTabBar(
            currentIndex: navigationShell.currentIndex,
            onTap: onTap,
            routes: routes,
          ),
          body: navigationShell,
        );
}

class JournalCupertinoScaffold extends CupertinoTabScaffold {
  final List<TabRoute> routes;
  final int currentIndex;
  final Function(int) onTap;

  JournalCupertinoScaffold({
    super.key,
    required this.routes,
    required this.currentIndex,
    required this.onTap,
  }) : super(
          tabBar: JournalCupertinoTabBar(
            onTap: onTap,
            currentIndex: currentIndex,
            routes: routes,
          ),
          tabBuilder: (_, int index) => routes[currentIndex].page,
        );
}
