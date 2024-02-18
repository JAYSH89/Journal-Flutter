import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum IconButtonType { close, add }

class JournalIconButton extends StatelessWidget {
  const JournalIconButton({
    super.key,
    required this.buttonType,
    required this.onPressed,
  });

  final IconButtonType buttonType;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) return _cupertinoIconButton();
    return _materialIconButton();
  }

  Widget _cupertinoIconButton() {
    switch (buttonType) {
      case IconButtonType.add:
        return _JournalCupertinoAddButton(onPressed: onPressed);
      default:
        return _JournalCupertinoCloseButton(onPressed: onPressed);
    }
  }

  Widget _materialIconButton() {
    switch (buttonType) {
      case IconButtonType.add:
        return _JournalMaterialAddButton(onPressed: onPressed);
      default:
        return _JournalMaterialCloseButton(onPressed: onPressed);
    }
  }
}

// Close button [x]

class _JournalCupertinoCloseButton extends CupertinoButton {
  const _JournalCupertinoCloseButton({
    required super.onPressed,
  }) : super(
          padding: EdgeInsets.zero,
          child: const Material(child: Icon(Icons.close)),
        );
}

class _JournalMaterialCloseButton extends IconButton {
  const _JournalMaterialCloseButton({
    required super.onPressed,
  }) : super(icon: const Icon(Icons.close));
}

// Add button [+]

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

// Next button [->]

class _JournalCupertinoNextButton extends CupertinoButton {
  const _JournalCupertinoNextButton({required super.onPressed})
      : super(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.chevron_forward),
        );
}

class _JournalMaterialNextButton extends IconButton {
  const _JournalMaterialNextButton({
    required super.onPressed,
  }) : super(icon: const Icon(Icons.navigate_next_rounded));
}

// Previous button [<-]

class _JournalCupertinoPreviousButton extends CupertinoButton {
  const _JournalCupertinoPreviousButton({required super.onPressed})
      : super(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.chevron_back),
        );
}

class _JournalMaterialPreviousButton extends IconButton {
  const _JournalMaterialPreviousButton({
    required super.onPressed,
  }) : super(icon: const Icon(Icons.navigate_before_rounded));
}
