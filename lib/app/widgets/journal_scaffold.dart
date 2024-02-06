import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_bottom_navigation_bar.dart';

class JournalMaterialScaffold extends Scaffold {
  final int selectedIndex;
  final List<TabRoute> routes;
  final Function(int) onTabBarItemTapped;

  JournalMaterialScaffold({
    super.key,
    required this.selectedIndex,
    required this.routes,
    required this.onTabBarItemTapped,
  }) : super(
          appBar: JournalMaterialAppBar(
            titleLabel: routes[selectedIndex].route.title,
          ),
          bottomNavigationBar: JournalBottomNavigationBar(
            currentIndex: selectedIndex,
            onItemTapped: onTabBarItemTapped,
            routes: routes,
          ),
          body: routes[selectedIndex].page,
        );
}

class JournalCupertinoScaffold extends CupertinoPageScaffold {
  final int selectedIndex;
  final List<TabRoute> routes;
  final Function(int) onTabBarItemTapped;

  JournalCupertinoScaffold({
    super.key,
    required this.selectedIndex,
    required this.routes,
    required this.onTabBarItemTapped,
  }) : super(
          child: CupertinoTabScaffold(
            tabBar: JournalCupertinoBottomNavigationBar(
              routes: routes,
              onTabBarItemTapped: onTabBarItemTapped,
            ),
            tabBuilder: (_, int index) {
              return JournalCupertinoSliverNavigationBar(
                titleLabel: routes[selectedIndex].route.title,
                child: routes[index].page,
              );
            },
          ),
        );
}

class JournalCupertinoSliverNavigationBar extends CustomScrollView {
  final String titleLabel;
  final Widget child;

  JournalCupertinoSliverNavigationBar({
    super.key,
    required this.titleLabel,
    required this.child,
  }) : super(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(largeTitle: Text(titleLabel)),
            SliverFillRemaining(child: child),
          ],
        );
}
