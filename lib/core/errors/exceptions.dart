import 'package:equatable/equatable.dart';

class InMemoryNotFoundException implements Exception, Equatable {
  final String message;

  InMemoryNotFoundException(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}

class InvalidInputException implements Exception, Equatable {
  final String message;

  InvalidInputException(this.message);

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}
