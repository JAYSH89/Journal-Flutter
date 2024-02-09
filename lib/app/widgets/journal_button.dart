import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';

class JournalButton extends StatelessWidget {
  const JournalButton({super.key, required this.onPressed});

  final String buttonTitle = "To developer settings";
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return CupertinoButton(
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: satoshiBold.copyWith(color: Colors.black),
        ),
      );
    }

    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        buttonTitle,
        style: satoshiBold.copyWith(color: Colors.black),
      ),
    );
  }
}
