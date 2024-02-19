import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_text_field.dart';
import 'package:journal/core/di/injection_container.dart';
import 'package:journal/core/theme/typography.dart';
import 'package:journal/core/util/date_time_extension.dart';
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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _datePicker(context),
            const SizedBox(height: 8),
            _amountInputField(label: "Amount:"),
          ],
        ),
      );

  Widget _amountInputField({required String label}) => _field(
        label: label,
        child: JournalTextField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
          onChanged: (_) {},
          onSubmitted: (_) {},
        ),
      );

  Widget _datePicker(BuildContext context) {
    return _field(
        label: "Date:",
        child: BlocSelector<CreateJournalEntryCubit, CreateJournalEntryState,
            DateTime>(
          selector: (state) => state.selectedDateTime ?? DateTime.now(),
          builder: (context, selectedDate) {
            final date = selectedDate ?? DateTime.now();
            return JournalTextField(
              controller: TextEditingController(text: date.dmy),
              readOnly: true,
              onTap: () async {
                if (Platform.isIOS) {
                  _showCupertinoDatePicker(
                      context: context,
                      onDateTimeChanged: (newDate) {
                        BlocProvider.of<CreateJournalEntryCubit>(context)
                            .selectDate(newDate);
                      });
                  return;
                }

                _showMaterialDatePicker(
                    context: context,
                    onFinish: (newDate) {
                      BlocProvider.of<CreateJournalEntryCubit>(context)
                          .selectDate(newDate);
                    });
              },
            );
          },
        ));
  }

  void _showMaterialDatePicker({
    required BuildContext context,
    required Function(DateTime) onFinish,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) onFinish(pickedDate);
  }

  void _showCupertinoDatePicker({
    required BuildContext context,
    required Function(DateTime) onDateTimeChanged,
  }) async {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            minimumDate: DateTime(2000),
            maximumDate: DateTime(2101),
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            showDayOfWeek: true,
            dateOrder: DatePickerDateOrder.dmy,
            onDateTimeChanged: onDateTimeChanged,
          ),
        ),
      ),
    );
  }

  Widget _field({required String label, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: satoshiBold),
          const SizedBox(height: 8),
          child,
        ],
      );
}
