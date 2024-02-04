import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/domain/repository/food_repository.dart';
import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:journal/profile/domain/repository/weight_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    FoodDataSource,
    JournalDataSource,
    WeightMeasurementDataSource,
    WeightRepository,
    FoodRepository,
  ],
)
void main() {}
