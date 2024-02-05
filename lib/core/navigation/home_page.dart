import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_bottom_navigation_bar.dart';
import 'package:journal/core/navigation/go_router.dart';
import 'package:journal/core/navigation/tab_route.dart';
import 'package:journal/food/presentation/food_page.dart';
import 'package:journal/journal/presentation/journal_page.dart';
import 'package:journal/profile/presentation/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final routes = <TabRoute>[
    (route: JournalRoute(), page: const JournalPage()),
    (route: FoodRoute(), page: const FoodPage()),
    (route: ProfileRoute(), page: const ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return _CupertinoScaffold(
        currentIndex: _currentIndex,
        routes: routes,
        onItemTapped: _onItemTapped,
      );
    }

    return _MaterialScaffold(
      currentIndex: _currentIndex,
      routes: routes,
      onItemTapped: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });
  }
}

class _MaterialScaffold extends StatelessWidget {
  final int currentIndex;
  final List<TabRoute> routes;
  final Function(int) onItemTapped;

  const _MaterialScaffold({
    super.key,
    required this.currentIndex,
    required this.routes,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: JournalAppBar(title: routes[currentIndex].route.title),
        bottomNavigationBar: JournalBottomNavigationBar(
          currentIndex: currentIndex,
          onItemTapped: onItemTapped,
          routes: routes.map((e) => e.route).toList(),
        ),
        body: routes[currentIndex].page,
      );
}

class _CupertinoScaffold extends StatelessWidget {
  final int currentIndex;
  final List<TabRoute> routes;
  final Function(int) onItemTapped;

  const _CupertinoScaffold({
    super.key,
    required this.currentIndex,
    required this.routes,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        middle: Text(
          routes[currentIndex].route.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: routes.map((e) {
            return BottomNavigationBarItem(
              icon: Icon(e.route.cupertinoIcon),
              label: e.route.title,
            );
          }).toList(),
          onTap: onItemTapped,
        ),
        tabBuilder: (_, int index) => routes[index].page,
      ),
    );
  }
}
