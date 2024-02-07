import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/journal_bottom_navigation_bar.dart';
import 'package:journal/app/widgets/journal_scaffold.dart';
import 'package:journal/core/navigation/go_router.dart';
import 'package:journal/food/presentation/food_page.dart';
import 'package:journal/journal/presentation/journal_page.dart';
import 'package:journal/profile/presentation/profile_page.dart';

class JournalScaffoldWithNavBar extends StatelessWidget {
  JournalScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  final routes = <Routes>[JournalRoute(), FoodRoute(), ProfileRoute()];

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return JournalCupertinoScaffold(
          routes: routes,
          navigationShell: navigationShell,
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
        );
      default:
        return JournalMaterialScaffold(
          routes: routes,
          navigationShell: navigationShell,
          onTap: _onTap,
        );
    }
  }

  void _onTap(int index) {
    final initialLocation = index == navigationShell.currentIndex;
    navigationShell.goBranch(index, initialLocation: initialLocation);
  }
}
