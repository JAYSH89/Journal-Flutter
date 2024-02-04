import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? dateOfBirth;

  const UserDetail({
    this.firstName,
    this.lastName,
    this.email,
    this.dateOfBirth,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        dateOfBirth,
      ];
}
