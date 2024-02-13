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

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  final String _title = "Food";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FoodCubit>(context).getAllFood();
  }

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        child: JournalCupertinoSliverAppBar(
          titleLabel: _title,
          trailing: JournalIconButton(
            buttonType: IconButtonType.add,
            onPressed: () {
              _onPressAdd(context, platform);
            },
          ),
          child: _FoodViewContent(),
        ),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(
        titleLabel: _title,
        actions: [
          JournalIconButton(
            buttonType: IconButtonType.add,
            onPressed: () {
              _onPressAdd(context, platform);
            },
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
            BlocSelector<FoodCubit, FoodState, List<Food>>(
              selector: (state) => state.foods,
              builder: (_, foods) => Expanded(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (_, index) => JournalInkWell(
                      onTap: () {
                        _showModal(context: context, food: foods[index]);
                      },
                      child: _foodCard(foods[index]),
                    ),
                  ),
                ),
              ),
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
                Text("${food.calories()} kcal", style: satoshiBold),
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
            "${food.amount} ${food.unit.name.capitalized}",
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

  void _showModal({
    required BuildContext context,
    required Food food,
  }) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      _showCupertinoModal(context: context, food: food);
      return;
    }

    _showMaterialModal(context: context, food: food);
  }

  void _showCupertinoModal({
    required BuildContext context,
    required Food food,
  }) {
    showCupertinoModalPopup(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 400,
          child: SafeArea(top: false, child: _FoodModal(food: food)),
        );
      },
    );
  }

  void _showMaterialModal({required BuildContext context, required Food food}) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => _FoodModal(food: food),
    );
  }
}

class _FoodModal extends StatelessWidget {
  const _FoodModal({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 400,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              _header(context, food.name, () => Navigator.pop(context)),
              const Spacer(),
              Row(
                children: [Expanded(child: _deleteButton(() {}))],
              ),
            ],
          ),
        ),
      );

  Widget _header(BuildContext context, String name, Function() onPressed) {
    return Row(
      children: <Widget>[
        Text(
          food.name,
          style: satoshiBlack.copyWith(fontSize: 22),
        ),
        const Spacer(),
        JournalIconButton(
          buttonType: IconButtonType.close,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _deleteButton(Function() onPressed) {
    return JournalTextButton(text: "Delete", onPressed: onPressed);
  }
}
