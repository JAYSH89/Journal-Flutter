import 'package:journal/profile/domain/models/user_detail.dart';

abstract class UserDetailsDataSource {
  UserDetail getUserDetail();

  Future<UserDetail> saveUserDetail(UserDetail userDetail);

  clear();
}
