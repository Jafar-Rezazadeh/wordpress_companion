import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
}

class ServerFailure extends Failure {
  final Response? response;

  const ServerFailure({
    required super.message,
    required this.response,
  });
  @override
  List<Object?> get props => [
        message,
        response,
      ];
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});

  @override
  List<Object?> get props => [message];
}
