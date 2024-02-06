import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_text_field.dart';
import 'package:journal/core/theme/typography.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) => const FoodView();
}

class FoodView extends StatelessWidget {
  const FoodView({super.key});

  final String _title = "Food";

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return CupertinoPageScaffold(
          child: JournalCupertinoAppBar(
            titleLabel: _title,
            child: const _FoodViewContent(),
          ),
        );
      default:
        return Scaffold(
          appBar: JournalMaterialAppBar(titleLabel: _title),
          body: const Center(child: _FoodViewContent()),
        );
    }
  }
}

class _FoodViewContent extends StatelessWidget {
  const _FoodViewContent({super.key});

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const JournalTextField(),
            Text("Hello, Food", style: satoshiRegular),
          ],
        ),
      );
}

