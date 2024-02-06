import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';

class JournalMaterialAppBar extends AppBar {
  final String titleLabel;

  JournalMaterialAppBar({super.key, required this.titleLabel})
      : super(
          backgroundColor: Colors.black,
          title: Text(
            titleLabel,
            style: satoshiBlack.copyWith(color: Colors.white),
          ),
          centerTitle: false,
        );
}

class JournalCupertinoAppBar extends CupertinoNavigationBar {
  final String titleLabel;

  JournalCupertinoAppBar({super.key, required this.titleLabel})
      : super(
          backgroundColor: Colors.black,
          middle: Text(titleLabel, style: const TextStyle(color: Colors.white)),
        );
}
