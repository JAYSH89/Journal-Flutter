import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/journal_bottom_navigation_bar.dart';
import 'package:journal/core/navigation/go_router.dart';

class JournalMaterialScaffold extends Scaffold {
  final List<Routes> routes;
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
  final List<Routes> routes;
  final StatefulNavigationShell navigationShell;
  final int currentIndex;
  final Function(int) onTap;

  JournalCupertinoScaffold({
    super.key,
    required this.routes,
    required this.navigationShell,
    required this.currentIndex,
    required this.onTap,
  }) : super(
          tabBar: JournalCupertinoTabBar(
            onTap: onTap,
            currentIndex: currentIndex,
            routes: routes,
          ),
          tabBuilder: (_, int index) => navigationShell,
        );
}
