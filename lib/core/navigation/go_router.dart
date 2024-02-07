import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/core/navigation/journal_scaffold_with_nav_bar.dart';
import 'package:journal/developer/developer_page.dart';
import 'package:journal/food/presentation/food_page.dart';
import 'package:journal/journal/presentation/journal_page.dart';
import 'package:journal/profile/presentation/profile_page.dart';

// final GlobalKey<NavigatorState> _rootNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'root');
//
// final GlobalKey<NavigatorState> _sectionANavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'sectionANav');
//
// final GlobalKey<NavigatorState> _sectionBNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'sectionBNav');
//
// final GlobalKey<NavigatorState> _sectionCNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'sectionCNav');

final GoRouter router = GoRouter(
  // navigatorKey: _rootNavigatorKey,
  initialLocation: JournalRoute().path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return JournalScaffoldWithNavBar(
          key: GlobalKey(debugLabel: "shell"),
          navigationShell: navigationShell,
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          // navigatorKey: _sectionANavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: JournalRoute().path,
              builder: (_, state) => JournalPage(key: state.pageKey),
              routes: <RouteBase>[
                GoRoute(
                    path: DeveloperRoute().path,
                    builder: (_, state) => DeveloperPage(key: state.pageKey)),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _sectionBNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
                path: FoodRoute().path,
                builder: (_, state) => FoodPage(key: state.pageKey)),
          ],
        ),
        StatefulShellBranch(
          // navigatorKey: _sectionCNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: ProfileRoute().path,
              builder: (_, state) => ProfilePage(key: state.pageKey),
            ),
          ],
        ),
      ],
    ),
  ],
);

sealed class Routes {
  late String path;
  late String title;
  late IconData materialIcon;
  late IconData cupertinoIcon;

  Routes({
    required this.path,
    required this.title,
    required this.materialIcon,
    required this.cupertinoIcon,
  });
}

class HomeRoute extends Routes {
  HomeRoute({
    super.path = '/home',
    super.title = 'Home',
    super.materialIcon = Icons.home,
    super.cupertinoIcon = CupertinoIcons.home,
  });
}

class JournalRoute extends Routes {
  JournalRoute({
    super.path = '/journal',
    super.title = 'Journal',
    super.materialIcon = Icons.calendar_today,
    super.cupertinoIcon = CupertinoIcons.calendar,
  });
}

class FoodRoute extends Routes {
  FoodRoute({
    super.path = '/food',
    super.title = 'Food',
    super.materialIcon = Icons.restaurant,
    super.cupertinoIcon = CupertinoIcons.bookmark,
  });
}

class ProfileRoute extends Routes {
  ProfileRoute({
    super.path = '/profile',
    super.title = 'Profile',
    super.materialIcon = Icons.person,
    super.cupertinoIcon = CupertinoIcons.profile_circled,
  });
}

class DeveloperRoute extends Routes {
  DeveloperRoute({
    super.path = 'developer',
    super.title = 'Developer',
    super.materialIcon = Icons.directions_bus_filled,
    super.cupertinoIcon = CupertinoIcons.bus,
  });
}
