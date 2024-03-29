import 'package:injectable/injectable.dart';
import 'package:journal/profile/data/datasource/user_details_data_source.dart';
import 'package:journal/profile/domain/models/user_detail.dart';

@Injectable(as: UserDetailsDataSource)
class InMemoryUserDetailDataSource extends UserDetailsDataSource {
  var user = UserDetail();

  @override
  UserDetail getUserDetail() => user;

  @override
  Future<UserDetail> saveUserDetail(UserDetail userDetail) async {
    user = userDetail;
    return user;
  }

  @override
  clear() {
    user = UserDetail();
  }
}
