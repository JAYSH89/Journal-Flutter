import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/repository/food_repository.dart';

part 'food_cubit.freezed.dart';

@Injectable()
class FoodCubit extends Cubit<FoodState> {
  FoodCubit(this._repository) : super(const FoodState());

  final FoodRepository _repository;

  void getAllFood() async {
    final result = await _repository.getAll();
    emit(state.copyWith(foods: result));
  }

  void deleteFood({required int id}) async {
    final success = await _repository.deleteFood(id: id);
    if (success) {
      getAllFood();
      return;
    }
    emit(state.copyWith(errorMessage: "Error deleting $id"));
  }
}

@freezed
class FoodState with _$FoodState {
  const factory FoodState({
    @Default([]) List<Food> foods,
    @Default(null) String? errorMessage,
  }) = _FoodState;
}
