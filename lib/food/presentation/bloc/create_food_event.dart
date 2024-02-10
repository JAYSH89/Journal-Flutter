part of 'create_food_bloc.dart';

@freezed
class CreateFoodEvent with _$CreateFoodEvent {
  const factory CreateFoodEvent.submit({
    required String name,
    required String carbs,
    required String proteins,
    required String fats,
    required String amount,
    required FoodUnit unit,
  }) = _Submit;
}
