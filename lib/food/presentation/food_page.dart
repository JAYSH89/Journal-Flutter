import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal/app/widgets/buttons/journal_add_button.dart';
import 'package:journal/app/widgets/journal_app_bar.dart';
import 'package:journal/app/widgets/journal_text_field.dart';
import 'package:journal/food/presentation/create_food_page.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) => const FoodView();
}

class FoodView extends StatelessWidget {
  const FoodView({super.key});

  final String _title = "Food";

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        child: JournalCupertinoSliverAppBar(
          titleLabel: _title,
          trailing: JournalAddButton(onPressed: () {
            _onPressAdd(context, platform);
          }),
          child: _FoodViewContent(),
        ),
      );
    }

    return Scaffold(
      appBar: JournalMaterialAppBar(
        titleLabel: _title,
        actions: [
          JournalAddButton(onPressed: () {
            _onPressAdd(context, platform);
          }),
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
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [JournalTextField(placeholder: "Search")]),
      );
}
