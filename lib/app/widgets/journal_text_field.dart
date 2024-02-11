import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';

class JournalTextField extends StatelessWidget {
  const JournalTextField({
    super.key,
    this.placeholder = "",
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
  });

  final String placeholder;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return JournalCupertinoTextField(
          keyboardType: keyboardType,
          placeholder: placeholder,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        );
      default:
        return JournalMaterialTextField(
          keyboardType: keyboardType,
          placeholder: placeholder,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        );
    }
  }
}

class JournalMaterialTextField extends TextField {
  static const OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  );

  JournalMaterialTextField({
    super.key,
    super.keyboardType,
    super.textInputAction,
    super.onChanged,
    super.onSubmitted,
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
    super.keyboardType,
    super.textInputAction,
    super.placeholder,
    super.onChanged,
    super.onSubmitted,
  }) : super(
          clearButtonMode: OverlayVisibilityMode.editing,
          style: satoshiRegular,
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.systemGrey),
            borderRadius: BorderRadius.circular(4.0),
          ),
          padding: const EdgeInsets.all(8.0),
        );
}
