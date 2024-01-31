import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/domain/repository/food_repository.dart';
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    FoodDataSource,
    WeightMeasurementDataSource,
    FoodRepository,
  ],
)
void main() {}
