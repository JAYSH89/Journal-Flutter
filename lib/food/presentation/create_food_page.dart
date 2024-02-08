import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/buttons/journal_add_button.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';

class CreateFoodPage extends StatelessWidget {
  const CreateFoodPage({super.key}) : _title = "Create food";

  final String _title;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return CupertinoPageScaffold(
          navigationBar: JournalCupertinoAppBar(titleLabel: _title),
          child: const Center(child: _CreateFoodViewContent()),
        );
      default:
        return Scaffold(
          appBar: JournalMaterialAppBar(titleLabel: _title),
          body: const Center(child: _CreateFoodViewContent()),
        );
    }
  }
}

class _CreateFoodViewContent extends StatelessWidget {
  const _CreateFoodViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Hello world");
  }
}
