import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/buttons/journal_text_button.dart';
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

    if (platform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        child: JournalCupertinoSliverAppBar(
          titleLabel: _title,
          child: _ProfileViewContent(),
        ),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(titleLabel: _title),
      body: _ProfileViewContent(),
    );
  }
}

class _ProfileViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 8),
            _weightChart(),
            const SizedBox(height: 8),
            _developerSettingsButton(() => context.go("/profile/developer")),
          ],
        ),
      );

  // TODO
  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Hello, NAME", style: satoshiBlack.copyWith(fontSize: 28)),
        const Spacer(),
        const SizedBox(width: 48, height: 48, child: Placeholder()),
      ],
    );
  }

  Widget _weightChart() => const SizedBox(
        height: 200,
        width: double.infinity,
        child: Placeholder(),
      );

  Widget _developerSettingsButton(Function() onPressed) => Row(
        children: [
          Expanded(
            child: JournalTextButton(
              text: "To developer settings",
              onPressed: onPressed,
            ),
          ),
        ],
      );
}
