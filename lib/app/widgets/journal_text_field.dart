import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';

class JournalTextField extends StatelessWidget {
  const JournalTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return JournalCupertinoTextField(placeholder: "Search");
      default:
        return JournalMaterialTextField(placeholder: "Search");
    }
  }
}

class JournalMaterialTextField extends TextField {
  static const OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  );

  JournalMaterialTextField({
    super.key,
    String? placeholder,
  }) : super(
          style: satoshiRegular,
          decoration: InputDecoration(
            errorBorder: border,
            focusedBorder: border,
            focusedErrorBorder: border,
            disabledBorder: border,
            enabledBorder: border,
            border: border,
            hintText: placeholder ?? "",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 0,
            ),
          ),
        );
}

class JournalCupertinoTextField extends CupertinoTextField {
  JournalCupertinoTextField({
    super.key,
    super.placeholder,
  }) : super(
          clearButtonMode: OverlayVisibilityMode.editing,
          style: satoshiRegular,
        );
}
