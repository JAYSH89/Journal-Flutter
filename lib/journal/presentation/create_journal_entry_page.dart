import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/core/di/injection_container.dart';
import 'package:journal/journal/presentation/cubit/create_journal_entry_cubit.dart';

class CreateJournalEntryPage extends StatelessWidget {
  const CreateJournalEntryPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<CreateJournalEntryCubit>(),
        child: const _CreateJournalEntryView(),
      );
}

class _CreateJournalEntryView extends StatelessWidget {
  const _CreateJournalEntryView() : _title = "New Journal Entry";

  final String _title;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: CupertinoPageScaffold(
          navigationBar: JournalCupertinoAppBar(titleLabel: _title),
          child: SafeArea(child: _CreateJournalEntryViewContent()),
        ),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(titleLabel: _title),
      body: SafeArea(child: _CreateJournalEntryViewContent()),
    );
  }
}

class _CreateJournalEntryViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
