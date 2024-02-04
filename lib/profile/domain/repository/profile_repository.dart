import 'package:journal/profile/domain/models/user_detail.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';

abstract class ProfileRepository {
  UserDetail getUserDetails();

  Future<UserDetail> saveUserDetails(UserDetail profile);

  clearUserDetails();

  List<WeightMeasurement> getAllWeightMeasurements();

  WeightMeasurement saveWeightMeasurement(WeightMeasurement measurement);

  deleteWeightMeasurement(String id);
}
