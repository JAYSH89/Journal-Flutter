import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';
import 'package:journal/core/util/string_extension.dart';
import 'package:journal/food/domain/models/food_unit.dart';

class JournalSegmentedControl extends StatefulWidget {
  const JournalSegmentedControl({super.key});

  @override
  State<JournalSegmentedControl> createState() {
    return _JournalSegmentedControlState();
  }
}

class _JournalSegmentedControlState extends State<JournalSegmentedControl> {
  FoodUnit selectedFoodUnit = FoodUnit.gram;

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) return _cupertinoSegmentControl();
    return _materialSegmentControl();
  }

  _JournalMaterialSegmentedControl _materialSegmentControl() {
    return _JournalMaterialSegmentedControl(
      segments: _buildMaterialSegments(),
      selected: <FoodUnit>{selectedFoodUnit},
      onSelectionChanged: (newSelection) {
        setState(() {
          selectedFoodUnit = newSelection.first;
        });
      },
    );
  }

  List<ButtonSegment<FoodUnit>> _buildMaterialSegments() => FoodUnit.values
      .map(
        (foodUnit) => ButtonSegment(
          value: foodUnit,
          label: Text(foodUnit.name.capitalized, style: satoshiRegular),
        ),
      )
      .toList();

  _JournalCupertinoSegmentedControl _cupertinoSegmentControl() {
    return _JournalCupertinoSegmentedControl(
      children: _buildCupertinoSegments(),
      onValueChanged: (value) {
        setState(() {
          selectedFoodUnit = value as FoodUnit;
        });
      },
      groupValue: selectedFoodUnit,
    );
  }

  Map<FoodUnit, Widget> _buildCupertinoSegments() {
    return {for (var e in FoodUnit.values) e: Text(e.name.capitalized)};
  }
}

class _JournalCupertinoSegmentedControl extends CupertinoSegmentedControl {
  _JournalCupertinoSegmentedControl({
    required super.children,
    required super.onValueChanged,
    required super.groupValue,
  });
}

class _JournalMaterialSegmentedControl extends SegmentedButton {
  const _JournalMaterialSegmentedControl({
    required super.segments,
    required super.selected,
    required super.onSelectionChanged,
  });
}
