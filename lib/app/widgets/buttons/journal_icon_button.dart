import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum IconButtonType { close, add, previous, forward }

class JournalIconButton extends StatelessWidget {
  const JournalIconButton({
    super.key,
    required this.buttonType,
    this.onPressed,
  });

  final IconButtonType buttonType;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) return _cupertinoIconButton();
    return _materialIconButton();
  }

  Widget _cupertinoIconButton() {
    switch (buttonType) {
      case IconButtonType.add:
        return _JournalCupertinoAddButton(onPressed: onPressed);
      case IconButtonType.forward:
        return _JournalCupertinoForwardButton(onPressed: onPressed);
      case IconButtonType.previous:
        return _JournalCupertinoPreviousButton(onPressed: onPressed);
      default:
        return _JournalCupertinoCloseButton(onPressed: onPressed);
    }
  }

  Widget _materialIconButton() {
    switch (buttonType) {
      case IconButtonType.add:
        return _JournalMaterialAddButton(onPressed: onPressed);
      case IconButtonType.forward:
        return _JournalMaterialForwardButton(onPressed: onPressed);
      case IconButtonType.previous:
        return _JournalMaterialPreviousButton(onPressed: onPressed);
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

class _JournalCupertinoForwardButton extends CupertinoButton {
  const _JournalCupertinoForwardButton({
    required super.onPressed,
  }) : super(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.chevron_forward),
        );
}

class _JournalMaterialForwardButton extends IconButton {
  const _JournalMaterialForwardButton({
    required super.onPressed,
  }) : super(icon: const Icon(Icons.navigate_next_rounded));
}

// Previous button [<-]

class _JournalCupertinoPreviousButton extends CupertinoButton {
  const _JournalCupertinoPreviousButton({
    required super.onPressed,
  }) : super(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.chevron_back),
        );
}

class _JournalMaterialPreviousButton extends IconButton {
  const _JournalMaterialPreviousButton({
    required super.onPressed,
  }) : super(icon: const Icon(Icons.navigate_before_rounded));
}
