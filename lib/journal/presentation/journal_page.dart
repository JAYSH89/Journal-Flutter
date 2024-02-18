import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/core/di/injection_container.dart';
import 'package:journal/core/theme/typography.dart';
import 'package:journal/journal/presentation/cubit/journal_cubit.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<JournalCubit>(),
        child: const JournalView(),
      );
}

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  final String _title = "Journal";

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: CupertinoPageScaffold(
          child: JournalCupertinoSliverAppBar(
            titleLabel: _title,
            child: _JournalViewContent(),
          ),
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
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _dateSelector(),
            const SizedBox(height: 12),
            _overview(),
            const SizedBox(height: 12),
            _entryList(),
          ],
        ),
      );

  Widget _dateSelector() => const Row(
        children: [
          Text("Back"),
          Spacer(),
          Text("10-06-2024"),
          Spacer(),
          Text("Forward"),
        ],
      );

  Widget _overview() => const SizedBox(
        width: double.infinity,
        height: 200,
        child: Placeholder(),
      );

  Widget _entryList() => Column(
        children: [
          _entryItem("Morning"),
          const SizedBox(height: 12),
          _entryItem("Afternoon"),
          const SizedBox(height: 12),
          _entryItem("Night"),
        ],
      );

  Widget _entryItem(String title) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: satoshiBlack.copyWith(fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 200,
            width: double.infinity,
            child: Placeholder(),
          ),
        ],
      );
}
