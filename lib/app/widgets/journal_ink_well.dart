import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class JournalInkWell extends StatelessWidget {
  const JournalInkWell({super.key, required this.onTap, required this.child});

  final Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          child: child,
        ),
      );
    }

    return InkWell(onTap: onTap, child: child);
  }
}
