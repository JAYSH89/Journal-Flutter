import 'package:flutter/material.dart';
import 'package:journal/app/widgets/journal_bottom_navigation_bar.dart';
import 'package:journal/app/widgets/journal_scaffold.dart';
import 'package:journal/core/navigation/go_router.dart';
import 'package:journal/food/presentation/food_page.dart';
import 'package:journal/journal/presentation/journal_page.dart';
import 'package:journal/profile/presentation/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final routes = <TabRoute>[
    (route: JournalRoute(), page: const JournalPage()),
    (route: FoodRoute(), page: const FoodPage()),
    (route: ProfileRoute(), page: const ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return JournalCupertinoScaffold(
          selectedIndex: _selectedIndex,
          routes: routes,
          onTabBarItemTapped: _onTabBarItemTapped,
        );
      default:
        return JournalMaterialScaffold(
          selectedIndex: _selectedIndex,
          routes: routes,
          onTabBarItemTapped: _onTabBarItemTapped,
        );
    }
  }

  void _onTabBarItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });
  }
}
