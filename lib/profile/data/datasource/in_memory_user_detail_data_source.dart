import 'package:journal/profile/data/datasource/user_details_data_source.dart';
import 'package:journal/profile/domain/models/user_detail.dart';

class InMemoryUserDetailDataSource extends UserDetailsDataSource {
  var user = const UserDetail();

  @override
  UserDetail getUserDetail() => user;

  @override
  UserDetail saveUserDetail(UserDetail userDetail) {
    user = userDetail;
    return user;
  }
}
