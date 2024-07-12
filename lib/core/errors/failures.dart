import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final StackTrace stackTrace;
  const Failure({required this.message, required this.stackTrace});

  get response => null;
}

class ServerFailure extends Failure {
  @override
  final Response? response;

  const ServerFailure({
    required super.message,
    required this.response,
    required super.stackTrace,
  });
  @override
  List<Object?> get props => [
        message,
        response,
      ];
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, required super.stackTrace});

  @override
  List<Object?> get props => [message];
}
