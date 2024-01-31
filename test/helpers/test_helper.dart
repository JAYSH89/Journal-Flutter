import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/domain/repository/food_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    FoodDataSource,
    FoodRepository,
  ],
)
void main() {}
