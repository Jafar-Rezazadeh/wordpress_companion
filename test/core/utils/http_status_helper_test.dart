import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/utils/http_status_helper.dart';

void main() {
  test(
      "should return some info as (string) when status code is one of [200 - 201 - 400 - 401 - 403 - 404 - 410 - 500]",
      () {
    //arrange
    final String ok = HttpStatusHelper.translateToMessage(200);
    final String create = HttpStatusHelper.translateToMessage(201);
    final String noResource = HttpStatusHelper.translateToMessage(400);
    final String notAuth = HttpStatusHelper.translateToMessage(401);
    final String forbidden = HttpStatusHelper.translateToMessage(403);
    final String notFound = HttpStatusHelper.translateToMessage(404);
    final String gone = HttpStatusHelper.translateToMessage(410);
    final String serverError = HttpStatusHelper.translateToMessage(500);

    //assert
    expect(ok, isNot(_defaultString()));
    expect(create, isNot(_defaultString()));
    expect(noResource, isNot(_defaultString()));
    expect(notAuth, isNot(_defaultString()));
    expect(forbidden, isNot(_defaultString()));
    expect(notFound, isNot(_defaultString()));
    expect(gone, isNot(_defaultString()));
    expect(serverError, isNot(_defaultString()));
  });

  test("should return (default) when status not match one of the cases", () {
    //assert
    expect(HttpStatusHelper.translateToMessage(406), _defaultString());
  });
}

String _defaultString() =>
    "خطای نامشخص، از صحت نام دامنه مطمئن شوید. Status code: 406";
