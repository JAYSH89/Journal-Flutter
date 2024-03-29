import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/core/theme/typography.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) => const JournalView();
}

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  final String _title = "Journal";

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        child: JournalCupertinoSliverAppBar(
          titleLabel: _title,
          child: _JournalViewContent(),
        ),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(titleLabel: _title),
      body: Center(child: _JournalViewContent()),
    );
  }
}

class _JournalViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello, Journal", style: satoshiRegular),
        ],
      );
}
