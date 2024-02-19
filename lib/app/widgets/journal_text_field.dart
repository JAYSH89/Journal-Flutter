import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';

class JournalTextField extends StatelessWidget {
  const JournalTextField({
    super.key,
    this.placeholder = "",
    this.keyboardType = TextInputType.text,
    this.controller,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.readOnly,
  });

  final String placeholder;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return JournalCupertinoTextField(
        keyboardType: keyboardType,
        controller: controller,
        placeholder: placeholder,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTap: onTap,
        readOnly: readOnly ?? false,
      );
    }

    return JournalMaterialTextField(
      keyboardType: keyboardType,
      controller: controller,
      placeholder: placeholder,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      readOnly: readOnly ?? false,
    );
  }
}

class JournalMaterialTextField extends TextField {
  static const OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  );

  JournalMaterialTextField({
    super.key,
    super.controller,
    super.keyboardType,
    super.textInputAction,
    super.onChanged,
    super.onSubmitted,
    super.onTap,
    super.readOnly,
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
    super.controller,
    super.keyboardType,
    super.textInputAction,
    super.placeholder,
    super.onChanged,
    super.onTap,
    super.readOnly,
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
