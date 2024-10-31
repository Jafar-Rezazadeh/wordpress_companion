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
        stackTrace,
      ];
}

class InternalFailure extends Failure {
  const InternalFailure({
    required super.message,
    required super.stackTrace,
  });

  @override
  List<Object?> get props => [
        message,
        stackTrace,
      ];
}

class FailureFactory {
  static Failure createFailure(Object object, StackTrace stackTrace) {
    if (object is DioException) {
      return ServerFailure(
        message: object.message.toString(),
        response: object.response,
        stackTrace: object.stackTrace,
      );
    } else {
      return InternalFailure(
        message: object.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
