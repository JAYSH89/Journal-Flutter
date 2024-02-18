import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/buttons/journal_icon_button.dart';
import 'package:journal/app/widgets/buttons/journal_text_button.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_ink_well.dart';
import 'package:journal/app/widgets/journal_text_field.dart';
import 'package:journal/core/di/injection_container.dart';
import 'package:journal/core/theme/typography.dart';
import 'package:journal/core/util/string_extension.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/presentation/cubit/food_cubit.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<FoodCubit>(),
        child: const FoodView(),
      );
}

class FoodView extends StatelessWidget {
  const FoodView({super.key});

  final String _title = "Food";

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: CupertinoPageScaffold(
          child: JournalCupertinoSliverAppBar(
            titleLabel: _title,
            trailing: JournalIconButton(
              buttonType: IconButtonType.add,
              onPressed: () => _onPressAdd(context, platform),
            ),
            child: _FoodViewContent(),
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
            onPressed: () => _onPressAdd(context, platform),
          ),
        ],
      ),
      body: Center(child: _FoodViewContent()),
    );
  }

  _onPressAdd(BuildContext context, TargetPlatform platform) {
    context.go("/food/create_food");
  }
}

class _FoodViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const JournalTextField(placeholder: "Search"),
            BlocBuilder<FoodCubit, FoodState>(
              builder: (context, state) {
                return Expanded(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      itemCount: state.foods.length,
                      itemBuilder: (_, index) => JournalInkWell(
                        onTap: () => _showModal(
                          context: context,
                          food: state.foods[index],
                        ),
                        child: _foodCard(state.foods[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );

  Widget _foodCard(Food food) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                _foodTitle(food: food),
                const Spacer(),
                Text(
                  "${food.calories().toStringAsFixed(0)} kcal",
                  style: satoshiBold,
                ),
              ],
            ),
          ),
          _foodDivider(),
        ],
      );

  Widget _foodTitle({required Food food}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(food.name, style: satoshiBold),
          Text(
            "${food.amount.toStringAsFixed(0)} ${food.foodUnit.name.capitalized}",
            style: satoshiRegular.copyWith(fontSize: 10),
          ),
        ],
      );

  Widget _foodDivider() => const Divider(
        color: Colors.grey,
        thickness: 1,
        height: 1,
        indent: 0,
        endIndent: 0,
      );

  void _showModal({required BuildContext context, required Food food}) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      _cupertinoModal(context: context, food: food);
      return;
    }

    _materialModal(context: context, food: food);
  }

  void _cupertinoModal({required BuildContext context, required Food food}) {
    showCupertinoModalPopup(
      useRootNavigator: true,
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<FoodCubit>(context),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 400,
          child: SafeArea(top: false, child: _FoodModal(food: food)),
        ),
      ),
    );
  }

  void _materialModal({required BuildContext context, required Food food}) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<FoodCubit>(context),
        child: _FoodModal(food: food),
      ),
    );
  }
}

class _FoodModal extends StatelessWidget {
  const _FoodModal({required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 16),
              _macroDisplay(),
              const SizedBox(height: 16),
              _calorieBarChart(),
              const Spacer(),
              _deleteButton(context),
            ],
          ),
        ),
      );

  Widget _header(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            food.name.capitalized,
            style: satoshiBlack.copyWith(fontSize: 26),
          ),
          const Spacer(),
          JournalIconButton(
            buttonType: IconButtonType.close,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );

  Widget _macroDisplay() => Row(
        children: [
          _macroBlock(
            title: "Fats",
            amount: food.fats,
            background: const Color.fromARGB(255, 231, 194, 53),
            percentage: food.percentageFats,
          ),
          const SizedBox(width: 16),
          _macroBlock(
            title: "Carbs",
            amount: food.carbs,
            background: const Color.fromARGB(255, 228, 110, 107),
            percentage: food.percentageCarbs,
          ),
          const SizedBox(width: 16),
          _macroBlock(
            title: "Proteins",
            amount: food.proteins,
            background: const Color.fromARGB(255, 71, 177, 242),
            percentage: food.percentageProteins,
          ),
        ],
      );

  Widget _calorieBarChart() => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 44,
          child: Stack(children: [_calorieBars(), _calorieOverlay()]),
        ),
      );

  Widget _calorieBars() => Row(
        children: [
          Expanded(
            flex: (food.percentageFats * 100).toInt(),
            child: Container(color: const Color.fromARGB(255, 231, 194, 53)),
          ),
          Expanded(
            flex: (food.percentageCarbs * 100).toInt(),
            child: Container(color: const Color.fromARGB(255, 228, 110, 107)),
          ),
          Expanded(
            flex: (food.percentageProteins * 100).toInt(),
            child: Container(color: const Color.fromARGB(255, 71, 177, 242)),
          ),
        ],
      );

  Widget _calorieOverlay() {
    final calorie = food.calories().toStringAsFixed(0);
    final quantity = food.amount.toStringAsFixed(0);
    final foodUnit = food.foodUnit.name.capitalized;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$quantity $foodUnit - $calorie kcal",
                style: satoshiBlack.copyWith(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _macroBlock({
    required String title,
    required double amount,
    required Color background,
    required double percentage,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 120,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: _macroBlockText(
                "$title:",
                style: satoshiBold.copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
            Center(
              child: _macroBlockText(
                amount.toStringAsFixed(0),
                style: satoshiBlack.copyWith(color: Colors.white, fontSize: 34),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${(percentage * 100).toStringAsFixed(2)} %",
                style: satoshiBold.copyWith(color: Colors.white, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _macroBlockText(String text, {TextStyle? style}) => Text(
        text,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget _deleteButton(BuildContext context) => Row(
        children: [
          Expanded(
            child: JournalTextButton(
              text: "Delete",
              onPressed: () {
                final id = food.id;
                if (id != null) {
                  BlocProvider.of<FoodCubit>(context).deleteFood(id: id);
                  Navigator.pop(context);
                }
              },
            ),
          )
        ],
      );
}
