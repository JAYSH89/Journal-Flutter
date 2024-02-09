import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal/food/domain/models/food_unit.dart';

part 'create_food_event.dart';

part 'create_food_state.dart';

part 'create_food_bloc.freezed.dart';

class CreateFoodBloc extends Bloc<CreateFoodEvent, CreateFoodState> {
  CreateFoodBloc() : super(const CreateFoodState.initial()) {
    on<CreateFoodEvent>((event, emit) {
      event.when(
        started: () {
          print("started");
        },
        submit: (
          String name,
          String carbs,
          String proteins,
          String fats,
          String amount,
          FoodUnit unit,
        ) {
          print(name);
          print(carbs);
          print(proteins);
          print(fats);
          print(amount);
          print(unit.name);
        },
      );
    });
  }
}
