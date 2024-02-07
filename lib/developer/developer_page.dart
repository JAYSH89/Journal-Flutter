import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/core/theme/typography.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) => const _DeveloperView();
}

class _DeveloperView extends StatelessWidget {
  const _DeveloperView({super.key});

  final String _title = "Developer";

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return CupertinoPageScaffold(
          navigationBar: JournalCupertinoAppBar(titleLabel: _title),
          child: const _DeveloperViewContent(),
        );
      default:
        return Scaffold(
          appBar: JournalMaterialAppBar(titleLabel: _title),
          body: const Center(child: _DeveloperViewContent()),
        );
    }
  }
}

class _DeveloperViewContent extends StatelessWidget {
  const _DeveloperViewContent({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text("Developer page", style: satoshiRegular),
      );
}
