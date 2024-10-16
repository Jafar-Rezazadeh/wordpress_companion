import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/utils/http_status_helper.dart';

void main() {
  test(
      "should return some info as (string) when status code is one of [200 - 201 - 400 - 401 - 403 - 404 - 410 - 500]",
      () {
    //arrange
    final HttpStatusHelper ok = HttpStatusHelper(status: 200);
    final HttpStatusHelper create = HttpStatusHelper(status: 201);
    final HttpStatusHelper noResource = HttpStatusHelper(status: 400);
    final HttpStatusHelper notAuth = HttpStatusHelper(status: 401);
    final HttpStatusHelper forbidden = HttpStatusHelper(status: 403);
    final HttpStatusHelper notFound = HttpStatusHelper(status: 404);
    final HttpStatusHelper gone = HttpStatusHelper(status: 410);
    final HttpStatusHelper serverError = HttpStatusHelper(status: 500);

    //assert
    expect(ok.translateToMessage(), isNot(_defaultString()));
    expect(create.translateToMessage(), isNot(_defaultString()));
    expect(noResource.translateToMessage(), isNot(_defaultString()));
    expect(notAuth.translateToMessage(), isNot(_defaultString()));
    expect(forbidden.translateToMessage(), isNot(_defaultString()));
    expect(notFound.translateToMessage(), isNot(_defaultString()));
    expect(gone.translateToMessage(), isNot(_defaultString()));
    expect(serverError.translateToMessage(), isNot(_defaultString()));
  });

  test("should return (default) when status not match one of the cases", () {
    //arrange
    final statusHelper = HttpStatusHelper(status: 406);

    //assert
    expect(statusHelper.translateToMessage(), _defaultString());
  });
}

String _defaultString() => "خطای نامشخص، از صحت نام دامنه مطمئن شوید.";
