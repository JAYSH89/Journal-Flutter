part of 'create_food_bloc.dart';

@freezed
class CreateFoodState with _$CreateFoodState {
  const factory CreateFoodState.initial() = _Initial;

  const factory CreateFoodState.validated() = _Validated;

  const factory CreateFoodState.validationError({
    required bool validName,
    required bool validCarbs,
    required bool validProteins,
    required bool validFats,
    required bool validAmount,
  }) = _ValidationError;
}
