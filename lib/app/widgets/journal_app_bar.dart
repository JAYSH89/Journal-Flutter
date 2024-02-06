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

class JournalCupertinoAppBar extends CustomScrollView {
  final String titleLabel;
  final Widget child;

  JournalCupertinoAppBar({
    super.key,
    required this.titleLabel,
    required this.child,
  }) : super(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(titleLabel, style: satoshiBlack),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: child,
            ),
          ],
        );
}
