import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_bottom_navigation_bar.dart';
import 'package:journal/core/navigation/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.routerState,
    required this.child,
  });

  final GoRouterState routerState;
  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final routes = [JournalRoute(), FoodRoute(), ProfileRoute()];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: JournalAppBar(title: _getTitle()),
        bottomNavigationBar: JournalBottomNavigationBar(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
          routes: routes,
        ),
        body: widget.child,
      );

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });
    context.go(routes[index].path);
  }

  String _getTitle() => routes
      .firstWhere((e) => e.path == widget.routerState.matchedLocation)
      .title;
}
