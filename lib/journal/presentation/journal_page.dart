import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/buttons/journal_icon_button.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/core/di/injection_container.dart';
import 'package:journal/core/theme/typography.dart';
import 'package:journal/core/util/date_time_extension.dart';
import 'package:journal/journal/presentation/cubit/journal_cubit.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<JournalCubit>(),
        child: const _JournalView(),
      );
}

class _JournalView extends StatelessWidget {
  const _JournalView({super.key});

  final String _title = "Journal";

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: CupertinoPageScaffold(
          child: JournalCupertinoSliverAppBar(
            titleLabel: _title,
            trailing: JournalIconButton(
              buttonType: IconButtonType.add,
              onPressed: () => _onPressAdd(context),
            ),
            child: _JournalViewContent(),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(
        titleLabel: _title,
        actions: [
          JournalIconButton(
            buttonType: IconButtonType.add,
            onPressed: () => _onPressAdd(context),
          ),
        ],
      ),
      body: Center(child: _JournalViewContent()),
    );
  }

  _onPressAdd(BuildContext context) {
    context.go("/journal/create_journal");
  }
}

class _JournalViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _dateSelector(context),
            const SizedBox(height: 12),
            _overview(),
            const SizedBox(height: 12),
            _entryList(),
          ],
        ),
      );

  Widget _dateSelector(BuildContext context) => Row(
        children: [
          JournalIconButton(
            buttonType: IconButtonType.previous,
            onPressed: () => BlocProvider.of<JournalCubit>(context)
                .changeDate(JournalSelectorDirection.previous),
          ),
          const Spacer(),
          BlocSelector<JournalCubit, JournalState, DateTime?>(
            selector: (state) => state.selectedDateTime,
            builder: (context, selectedDate) {
              final date = selectedDate ?? DateTime.now();
              return Text(date.dmy, style: satoshiBlack.copyWith(fontSize: 20));
            },
          ),
          const Spacer(),
          JournalIconButton(
            buttonType: IconButtonType.forward,
            onPressed: () => BlocProvider.of<JournalCubit>(context)
                .changeDate(JournalSelectorDirection.forward),
          ),
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
