import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/theme/typography.dart';
import 'package:journal/core/util/string_extension.dart';
import 'package:journal/food/domain/models/food_unit.dart';

// TODO: This segmented control is for create_food - Make it more dynamic

class JournalSegmentedControl extends StatefulWidget {
  const JournalSegmentedControl({
    super.key,
    required this.selectedFoodUnit,
    required this.onSelectionChanged,
  });

  final FoodUnit selectedFoodUnit;
  final Function(FoodUnit) onSelectionChanged;

  @override
  State<JournalSegmentedControl> createState() {
    return _JournalSegmentedControlState();
  }
}

class _JournalSegmentedControlState extends State<JournalSegmentedControl> {
  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) return _cupertinoSegmentControl();
    return _materialSegmentControl();
  }

  _JournalMaterialSegmentedControl _materialSegmentControl() {
    return _JournalMaterialSegmentedControl(
      segments: _buildMaterialSegments(),
      selected: <FoodUnit>{widget.selectedFoodUnit},
      onSelectionChanged: (newSelection) {
        widget.onSelectionChanged(newSelection.first);
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
        final newSelection = value as FoodUnit;
        widget.onSelectionChanged(newSelection);
      },
      groupValue: widget.selectedFoodUnit,
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
  }) : super(
          showSelectedIcon: false,
        );
}
