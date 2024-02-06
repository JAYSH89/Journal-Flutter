import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

    switch (platform) {
      case TargetPlatform.iOS:
        return CupertinoPageScaffold(
          child: JournalCupertinoAppBar(
            titleLabel: _title,
            child: const _JournalViewContent(),
          ),
        );
      default:
        return Scaffold(
          appBar: JournalMaterialAppBar(titleLabel: _title),
          body: const Center(child: _JournalViewContent()),
        );
    }
  }
}

class _JournalViewContent extends StatelessWidget {
  const _JournalViewContent({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Hello, Journal", style: satoshiRegular),
          _buildButton(context)
        ],
      );

  Widget _buildButton(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    const String buttonTitle = "To developer settings";

    switch (platform) {
      case TargetPlatform.iOS:
        return CupertinoButton(
          child: Text(buttonTitle, style: satoshiBold.copyWith(color: Colors.black)),
          onPressed: () {
            GoRouter.of(context).go("/journal/developer");
          },
        );
      default:
        return MaterialButton(
          child: Text(buttonTitle, style: satoshiBold.copyWith(color: Colors.black)),
          onPressed: () {
            GoRouter.of(context).go("/journal/developer");
          },
        );
    }
  }
}
