import 'package:injectable/injectable.dart';
import 'package:journal/profile/data/datasource/user_details_data_source.dart';
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:journal/profile/domain/models/user_detail.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';
import 'package:journal/profile/domain/repository/profile_repository.dart';

@Singleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final WeightMeasurementDataSource weightMeasurementDataSource;
  final UserDetailsDataSource userDetailsDataSource;

  ProfileRepositoryImpl({
    required this.weightMeasurementDataSource,
    required this.userDetailsDataSource,
  });

  @override
  UserDetail getUserDetails() {
    return userDetailsDataSource.getUserDetail();
  }

  @override
  Future<UserDetail> saveUserDetails(UserDetail profile) {
    return userDetailsDataSource.saveUserDetail(profile);
  }

  @override
  clearUserDetails() {
    userDetailsDataSource.clear();
  }

  @override
  List<WeightMeasurement> getAllWeightMeasurements() {
    return weightMeasurementDataSource.getAll();
  }

  @override
  WeightMeasurement saveWeightMeasurement(WeightMeasurement measurement) {
    return weightMeasurementDataSource.save(measurement);
  }

  @override
  deleteWeightMeasurement(String id) {
    weightMeasurementDataSource.delete(id);
  }
}
