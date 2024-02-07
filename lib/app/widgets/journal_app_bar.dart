import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';

class JournalMaterialAppBar extends AppBar {
  final String titleLabel;

  JournalMaterialAppBar({super.key, required this.titleLabel})
      : super(
          title: Text(titleLabel, style: satoshiBlack),
        );
}

class JournalCupertinoAppBar extends CupertinoNavigationBar {
  final String titleLabel;

  JournalCupertinoAppBar({
    super.key,
    required this.titleLabel,
  }) : super(middle: Text(titleLabel));
}

class JournalCupertinoSliverAppBar extends CustomScrollView {
  final String titleLabel;
  final Widget child;

  JournalCupertinoSliverAppBar({
    super.key,
    required this.titleLabel,
    required this.child,
  }) : super(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(titleLabel, style: satoshiBlack),
            ),
            SliverFillRemaining(child: child),
          ],
        );
}
