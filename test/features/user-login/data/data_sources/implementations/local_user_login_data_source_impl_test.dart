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
      localUserLoginDataSourceImpl = LocalUserLoginDataSourceImpl.test(
        sharedPreferences: mockSharedPreferences,
      );
    },
  );
  group("saveCredentials -", () {
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

  group("getLastCredentials -", () {
    test(
      "should throw (Exception) when any exception thrown while getting credentials",
      () {
        //arrange
        when(
          () => mockSharedPreferences.getString(userNameKey),
        ).thenAnswer((invocation) => "");

        when(
          () => mockSharedPreferences.getString(applicationPasswordKey),
        ).thenAnswer((invocation) => throw Exception());

        when(
          () => mockSharedPreferences.getString(domainKey),
        ).thenAnswer((invocation) => "");

        //act
        final result = localUserLoginDataSourceImpl.getLastCredentials();

        //assert
        expect(result, throwsA(isA<Exception>()));
      },
    );

    test(
      "should return (UserCredentialsModel) when  getLastCredentials is successful even fields are empty",
      () async {
        //arrange
        when(
          () => mockSharedPreferences.getString(userNameKey),
        ).thenAnswer((invocation) => "test");

        when(
          () => mockSharedPreferences.getString(applicationPasswordKey),
        ).thenAnswer((invocation) => "test1234");

        when(
          () => mockSharedPreferences.getString(domainKey),
        ).thenAnswer((invocation) => "https://example.com");

        //act
        final userCredentials = await localUserLoginDataSourceImpl.getLastCredentials();

        //assert
        expect(userCredentials, isA<UserCredentialsModel>());
        expect(userCredentials.userName, "test");
        expect(userCredentials.applicationPassword, "test1234");
        expect(userCredentials.domain, "https://example.com");
      },
    );
  });
}
