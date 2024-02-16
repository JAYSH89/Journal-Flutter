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

  void getAllFood() {
    final result = _repository.getAll();
    emit(state.copyWith(foods: result));
  }

  void deleteFood(String id) {
    _repository.deleteFood(id);
    getAllFood();
  }
}

@freezed
class FoodState with _$FoodState {
  const factory FoodState({
    @Default([]) List<Food> foods,
  }) = _FoodState;
}
