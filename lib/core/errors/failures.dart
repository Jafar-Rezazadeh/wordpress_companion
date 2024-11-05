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
  final DioException dioException;

  const ServerFailure({
    required super.message,
    required this.response,
    required this.dioException,
    required super.stackTrace,
  });
  @override
  List<Object?> get props => [
        message,
        response,
        stackTrace,
        dioException,
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
        message: object.error != null
            ? object.error.toString()
            : object.message.toString(),
        dioException: object,
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
