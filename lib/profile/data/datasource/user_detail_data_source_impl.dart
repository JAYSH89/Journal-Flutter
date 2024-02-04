import 'package:journal/profile/data/datasource/user_details_data_source.dart';
import 'package:journal/profile/domain/models/user_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailDataSourceImpl extends UserDetailsDataSource {
  final SharedPreferences sharedPreferences;

  static const firstNameKey = "first_name";
  static const lastNameKey = "last_name";
  static const emailKey = "email";
  static const dateOfBirthKey = "date_of_birth";

  UserDetailDataSourceImpl({required this.sharedPreferences});

  @override
  UserDetail getUserDetail() {
    final firstName = sharedPreferences.getString(firstNameKey);
    final lastName = sharedPreferences.getString(lastNameKey);
    final email = sharedPreferences.getString(emailKey);
    final dateOfBirth = sharedPreferences.getString(dateOfBirthKey);

    return UserDetail(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateOfBirth: dateOfBirth == null ? null : DateTime.parse(dateOfBirth),
    );
  }

  @override
  Future<UserDetail> saveUserDetail(UserDetail userDetail) async {
    final firstName = userDetail.firstName;
    final lastName = userDetail.lastName;
    final email = userDetail.email;
    final dateOfBirth = userDetail.dateOfBirth?.toIso8601String();

    if (firstName != null) {
      await sharedPreferences.setString(firstNameKey, firstName);
    }

    if (lastName != null) {
      await sharedPreferences.setString(lastNameKey, lastName);
    }

    if (email != null) {
      await sharedPreferences.setString(emailKey, email);
    }

    if (dateOfBirth != null) {
      await sharedPreferences.setString(dateOfBirthKey, dateOfBirth);
    }

    return UserDetail(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateOfBirth: dateOfBirth == null ? null : DateTime.parse(dateOfBirth),
    );
  }

  @override
  clear() async {
    await sharedPreferences.remove(firstNameKey);
    await sharedPreferences.remove(lastNameKey);
    await sharedPreferences.remove(emailKey);
    await sharedPreferences.remove(dateOfBirthKey);
  }
}
