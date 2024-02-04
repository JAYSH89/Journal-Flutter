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
    final first = sharedPreferences.getString(firstNameKey);
    final last = sharedPreferences.getString(lastNameKey);
    final email = sharedPreferences.getString(emailKey);
    final birthday = sharedPreferences.getString(dateOfBirthKey);

    return UserDetail(
      firstName: first,
      lastName: last,
      email: email,
      dateOfBirth: birthday == null ? null : DateTime.parse(birthday),
    );
  }

  @override
  UserDetail saveUserDetail(UserDetail userDetail) {
    final first = userDetail.firstName;
    final last = userDetail.lastName;
    final email = userDetail.email;
    final birthday = userDetail.dateOfBirth?.toIso8601String();

    if (first != null) sharedPreferences.setString(firstNameKey, first);
    if (last != null) sharedPreferences.setString(lastNameKey, last);
    if (email != null) sharedPreferences.setString(emailKey, email);
    if (birthday != null) sharedPreferences.setString(dateOfBirthKey, birthday);

    return UserDetail(
      firstName: first,
      lastName: last,
      email: email,
      dateOfBirth: birthday == null ? null : DateTime.parse(birthday),
    );
  }
}
