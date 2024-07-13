import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalUserLoginDataSourceImpl localUserLoginDataSourceImpl;

  String userNameKey = "userName";
  String applicationPasswordKey = "applicationPassword";
  String domainKey = "domain";

  setUp(
    () {
      mockSharedPreferences = MockSharedPreferences();
      localUserLoginDataSourceImpl = LocalUserLoginDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
      );
    },
  );
  group("save credentials -", () {
    test(
      "should return (UserCredentialsModel) when SaveCredentials is successful",
      () async {
        //arrange
        when(
          () => mockSharedPreferences.setString(
            userNameKey,
            any(),
          ),
        ).thenAnswer((invocation) async => true);
        when(
          () => mockSharedPreferences.setString(
            applicationPasswordKey,
            any(),
          ),
        ).thenAnswer((invocation) async => true);
        when(
          () => mockSharedPreferences.setString(
            domainKey,
            any(),
          ),
        ).thenAnswer((invocation) async => true);

        //act
        final result = await localUserLoginDataSourceImpl.saveCredentials(
          (
            name: "test",
            applicationPassword: "test1234",
            domain: "https://example.com",
          ),
        );

        //assert
        expect(result, isA<UserCredentialsModel>());
      },
    );

    test(
      "should throw (Exception) when even one key is not saved",
      () {
        //arrange
        when(
          () => mockSharedPreferences.setString(userNameKey, any()),
        ).thenAnswer((invocation) async => true);

        when(
          () => mockSharedPreferences.setString(applicationPasswordKey, any()),
        ).thenAnswer((invocation) async => false);

        when(
          () => mockSharedPreferences.setString(domainKey, any()),
        ).thenAnswer((invocation) async => true);

        //act
        final result = localUserLoginDataSourceImpl.saveCredentials(
          (
            name: "test",
            applicationPassword: "test1234",
            domain: "https://example.com",
          ),
        );

        //assert
        expect(result, throwsA(isA<Exception>()));
      },
    );
  });
}
