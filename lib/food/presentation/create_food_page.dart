import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/buttons/journal_segmented_button.dart';
import 'package:journal/app/widgets/buttons/journal_text_button.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_text_field.dart';
import 'package:journal/core/theme/typography.dart';

class CreateFoodPage extends StatelessWidget {
  const CreateFoodPage({super.key}) : _title = "Create food";

  final String _title;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        navigationBar: JournalCupertinoAppBar(titleLabel: _title),
        child: SafeArea(child: _CreateFoodViewContent()),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(titleLabel: _title),
      body: SafeArea(child: _CreateFoodViewContent()),
    );
  }
}

class _CreateFoodViewContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _journalInputRow(label: "Name:"),
              const SizedBox(height: 20),
              _macroRow(),
              const SizedBox(height: 20),
              _journalAmountRow(label: "Amount:"),
              const SizedBox(height: 20),
              _submitButton(onPressed: () {}),
            ],
          ),
        ),
      );

  Widget _macroRow() => Row(
        children: [
          Expanded(child: _journalInputRow(label: "Carbs:")),
          const SizedBox(width: 8),
          Expanded(child: _journalInputRow(label: "Proteins:")),
          const SizedBox(width: 8),
          Expanded(child: _journalInputRow(label: "Fats:")),
        ],
      );

  Widget _journalAmountRow({String label = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: satoshiBold),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: JournalTextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.go,
                onSubmitted: (_) {},
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(child: JournalSegmentedControl()),
          ],
        ),
      ],
    );
  }

  Widget _journalInputRow({
    String label = "",
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: satoshiBold),
        const SizedBox(height: 8),
        JournalTextField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
        ),
      ],
    );
  }

  Widget _submitButton({required Function() onPressed}) => Row(
        children: [
          Expanded(
            child: JournalTextButton(text: "Save", onPressed: onPressed),
          ),
        ],
      );
}