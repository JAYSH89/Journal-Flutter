import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JournalInkWell extends StatelessWidget {
  const JournalInkWell({super.key, required this.onTap, required this.child});

  final Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
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
