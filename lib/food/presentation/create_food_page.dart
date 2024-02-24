import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/buttons/journal_segmented_button.dart';
import 'package:journal/app/widgets/buttons/journal_text_button.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_text_field.dart';
import 'package:journal/core/di/injection_container.dart';
import 'package:journal/core/theme/typography.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/food/presentation/cubit/create_food_cubit.dart';

class CreateFoodPage extends StatelessWidget {
  const CreateFoodPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<CreateFoodCubit>(),
        child: BlocListener<CreateFoodCubit, CreateFoodState>(
          listener: (context, state) {
            if (state.formSubmitted == true) context.pop();
          },
          child: const _CreateFoodView(),
        ),
      );
}

class _CreateFoodView extends StatelessWidget {
  const _CreateFoodView() : _title = "Add food";

  final String _title;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: CupertinoPageScaffold(
          navigationBar: JournalCupertinoAppBar(titleLabel: _title),
          child: SafeArea(child: _CreateFoodViewContent()),
        ),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(titleLabel: _title),
      body: SafeArea(child: _CreateFoodViewContent()),
    );
  }
}

class _CreateFoodViewContent extends StatefulWidget {
  @override
  State<_CreateFoodViewContent> createState() => _CreateFoodViewContentState();
}

class _CreateFoodViewContentState extends State<_CreateFoodViewContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _journalInputRow(
              key: CreateFoodTextFieldKey.name,
              label: "Name:",
            ),
            const SizedBox(height: 20),
            _macroRow(),
            const SizedBox(height: 20),
            _journalAmountRow(label: "Amount:"),
            const SizedBox(height: 20),
            _submitButton(onPressed: () {
              BlocProvider.of<CreateFoodCubit>(context).submit();
            }),
          ],
        ),
      ),
    );
  }

  Widget _macroRow() => Row(
        children: [
          Expanded(
            child: _journalInputRow(
              key: CreateFoodTextFieldKey.carbs,
              label: "Carbs:",
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _journalInputRow(
              key: CreateFoodTextFieldKey.proteins,
              label: "Proteins:",
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _journalInputRow(
                key: CreateFoodTextFieldKey.fats, label: "Fats:"),
          ),
        ],
      );

  Widget _journalAmountRow({
    CreateFoodTextFieldKey key = CreateFoodTextFieldKey.amount,
    String label = "",
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: satoshiBold),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: JournalTextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.go,
                onChanged: (text) {
                  context.read<CreateFoodCubit>().setText(key, text);
                },
                onSubmitted: (_) {},
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: BlocSelector<CreateFoodCubit, CreateFoodState, FoodUnit>(
                selector: (state) => state.unit,
                builder: (_, unit) => JournalSegmentedControl(
                  selectedFoodUnit: unit,
                  onSelectionChanged: (value) {
                    context.read<CreateFoodCubit>().setUnit(value);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _journalInputRow({
    required CreateFoodTextFieldKey key,
    String label = "",
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    bool isError = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: satoshiBold),
        const SizedBox(height: 8),
        JournalTextField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: (text) {
            context.read<CreateFoodCubit>().setText(key, text);
          },
        ),
        if (isError) ...[
          const SizedBox(height: 8),
          Text(
            "Error occurred",
            style: satoshiRegular.copyWith(color: Colors.red),
          )
        ],
      ],
    );
  }

  Widget _submitButton({required Function() onPressed}) => Row(
        children: [
          Expanded(
            child: JournalTextButton(text: "Save", onPressed: onPressed),
          ),
        ],
      );
}
