import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';

class JournalTextButton extends StatelessWidget {
  const JournalTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        color: CupertinoColors.black,
        onPressed: onPressed,
        child: Text(text, style: satoshiBold),
      );
    }

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      onPressed: onPressed,
      child: Text(text, style: satoshiBold),
    );
  }
}
