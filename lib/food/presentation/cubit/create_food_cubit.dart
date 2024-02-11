import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal/food/domain/models/food_unit.dart';

part 'create_food_cubit.freezed.dart';

enum CreateFoodTextFieldKey {
  name,
  carbs,
  proteins,
  fats,
  amount,
  unit,
}

class CreateFoodCubit extends Cubit<CreateFoodState> {
  CreateFoodCubit() : super(const CreateFoodState());

  void setText(CreateFoodTextFieldKey key, String text) {
    final currentFields = state.fields;
    final Map<CreateFoodTextFieldKey, String> fields = Map.from(currentFields)
      ..[key] = text;

    emit(state.copyWith(fields: fields));
  }

  void setUnit(FoodUnit unit) {
    emit(state.copyWith(unit: unit));
  }

  void submit() {
    print("Submit:");
  }

  bool _validateTextInput(String? input) {
    if (input == null) return false;
    return input.isNotEmpty;
  }

  bool _validateNumericInput(String? input) {
    if (input == null) return false;
    if (input.isEmpty) return false;

    final parsedInput = double.tryParse(input);
    if (parsedInput == null || parsedInput.isNegative) return false;

    return true;
  }
}

@freezed
class CreateFoodState with _$CreateFoodState {
  const factory CreateFoodState({
    @Default({}) Map<CreateFoodTextFieldKey, String> fields,
    @Default(FoodUnit.gram) FoodUnit unit,
  }) = _CreateFoodState;
}
