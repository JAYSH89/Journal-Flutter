import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_detail.freezed.dart';

@freezed
class UserDetail with _$UserDetail {
  factory UserDetail({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dateOfBirth,
  }) = _UserDetail;
}
