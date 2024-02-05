import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/core/navigation/home_page.dart';

final GoRouter router = GoRouter(
  initialLocation: HomeRoute().path,
  routes: [
    GoRoute(
      path: HomeRoute().path,
      builder: (_, __) => const HomePage(),
    )
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
