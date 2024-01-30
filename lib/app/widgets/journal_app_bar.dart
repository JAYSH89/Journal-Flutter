import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';

class JournalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const JournalAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    return AppBar(
      backgroundColor: Colors.black,
      title: Text(title, style: satoshiBlack.copyWith(color: Colors.white)),
      centerTitle: platform == TargetPlatform.iOS,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
