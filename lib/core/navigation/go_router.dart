import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/core/navigation/home_page.dart';
import 'package:journal/food/presentation/food_page.dart';
import 'package:journal/journal/presentation/journal_page.dart';
import 'package:journal/profile/presentation/profile_page.dart';

final GoRouter router = GoRouter(
  initialLocation: JournalRoute().path,
  routes: [
    ShellRoute(
      builder: (_, state, child) => HomePage(routerState: state, child: child),
      routes: _routes,
    ),
  ],
);

final List<RouteBase> _routes = <RouteBase>[
  GoRoute(
    path: JournalRoute().path,
    builder: (_, __) => const JournalPage(),
    // pageBuilder: (context, state) =>
    //     CustomTransitionPage(
    //       key: state.pageKey,
    //       child: const JournalPage(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: CurveTween(curve: Curves.easeInOutCirc)
    //               .animate(animation),
    //           child: child,
    //         );
    //       },
    //     ),
  ),
  GoRoute(
    path: FoodRoute().path,
    builder: (_, __) => const FoodPage(),
    // pageBuilder: (context, state) =>
    //     CustomTransitionPage(
    //       key: state.pageKey,
    //       child: const FoodPage(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: CurveTween(curve: Curves.easeInOutCirc)
    //               .animate(animation),
    //           child: child,
    //         );
    //       },
    //     ),
  ),
  GoRoute(
    path: ProfileRoute().path,
    builder: (_, __) => const ProfilePage(),
    // pageBuilder: (context, state) =>
    //     CustomTransitionPage(
    //       key: state.pageKey,
    //       child: const ProfilePage(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: CurveTween(curve: Curves.easeInOutCirc)
    //               .animate(animation),
    //           child: child,
    //         );
    //       },
    //     ),
  ),
];

sealed class Routes {
  late String path;
  late String title;
  late IconData icon;

  Routes({
    required this.path,
    required this.title,
    required this.icon,
  });
}

class JournalRoute extends Routes {
  JournalRoute({
    super.path = '/journal',
    super.title = 'Journal',
    super.icon = Icons.calendar_today,
  });
}

class FoodRoute extends Routes {
  FoodRoute({
    super.path = '/food',
    super.title = 'Food',
    super.icon = Icons.restaurant,
  });
}

class ProfileRoute extends Routes {
  ProfileRoute({
    super.path = '/profile',
    super.title = 'Profile',
    super.icon = Icons.person,
  });
}
