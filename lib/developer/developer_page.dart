import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/core/theme/typography.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

  @override
  Widget build(BuildContext context) => _DeveloperView();
}

class _DeveloperView extends StatelessWidget {
  final String _title = "Developer";

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: JournalCupertinoAppBar(titleLabel: _title),
        child: _DeveloperViewContent(),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(titleLabel: _title),
      body: Center(child: _DeveloperViewContent()),
    );
  }
}

class _DeveloperViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Text("Developer page", style: satoshiRegular),
      );
}
