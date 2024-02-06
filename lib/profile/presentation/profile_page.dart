import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/core/theme/typography.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => const ProfileView();
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  final String _title = "Profile";

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    switch (platform) {
      case TargetPlatform.iOS:
        return CupertinoPageScaffold(
          child: JournalCupertinoAppBar(
            titleLabel: _title,
            child: const _ProfileViewContent(),
          ),
        );
      default:
        return Scaffold(
          appBar: JournalMaterialAppBar(titleLabel: _title),
          body: const Center(child: _ProfileViewContent()),
        );
    }
  }
}

class _ProfileViewContent extends StatelessWidget {
  const _ProfileViewContent({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Text("Hello, Profile", style: satoshiRegular),
      );
}
