import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JournalAddButton extends StatelessWidget {
  const JournalAddButton({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return _JournalCupertinoAddButton(onPressed: onPressed);
    }

    return _JournalMaterialAddButton(onPressed: onPressed);
  }
}

class _JournalCupertinoAddButton extends CupertinoButton {
  const _JournalCupertinoAddButton({
    required super.onPressed,
  }) : super(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add_circled),
        );
}

class _JournalMaterialAddButton extends IconButton {
  const _JournalMaterialAddButton({
    required super.onPressed,
  }) : super(icon: const Icon(Icons.add));
}
