import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/widgets/failure_widget.dart';

void main() {
  final serverFailureMessage = find.byKey(const Key("server_failure"));
  final internalFailureMessage = find.byKey(const Key("internal_failure"));
  testWidgets(
      'should render _showServerFailureMessage when failure is ServerFailure',
      (tester) async {
    //arrange
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FailureWidget(
          failure: ServerFailure(
            message: "message",
            dioException: DioException(requestOptions: RequestOptions()),
            response: Response(requestOptions: RequestOptions()),
            stackTrace: StackTrace.current,
          ),
        ),
      ),
    ));

    //assert
    expect(serverFailureMessage, findsOneWidget);
    expect(internalFailureMessage, findsNothing);
  });

  testWidgets(
      "should render _showInternalFailureMessage when failure is InternalFailure",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: FailureWidget(
            failure: InternalFailure(
              message: "message",
              stackTrace: StackTrace.fromString("stackTraceString"),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    //assert
    expect(internalFailureMessage, findsOneWidget);
    expect(serverFailureMessage, findsNothing);
  });
}
