import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalLoginDataSourceImpl localLoginDataSourceImpl;

  String userNameKey = "userName";
  String applicationPasswordKey = "applicationPassword";
  String domainKey = "domain";
  String rememberMeKey = "rememberMe";

  setUp(
    () {
      mockSharedPreferences = MockSharedPreferences();
      localLoginDataSourceImpl = LocalLoginDataSourceImpl.instance(
        sharedPreferences: mockSharedPreferences,
      );
    },
  );

  void verifyAllEntriesCalledToRemove() {
    verify(
      () => mockSharedPreferences.remove(userNameKey),
    ).called(1);

    verify(
      () => mockSharedPreferences.remove(applicationPasswordKey),
    ).called(1);

    verify(
      () => mockSharedPreferences.remove(domainKey),
    ).called(1);

    verify(
      () => mockSharedPreferences.remove(rememberMeKey),
    ).called(1);
  }

  group("saveCredentials -", () {
    test(
      "should set all variables and return (UserCredentialsModel) when SaveCredentials is successful",
      () async {
        //arrange
        when(
          () => mockSharedPreferences.setString(userNameKey, any()),
        ).thenAnswer((invocation) async => true);
        when(
          () => mockSharedPreferences.setString(applicationPasswordKey, any()),
        ).thenAnswer((invocation) async => true);
        when(
          () => mockSharedPreferences.setString(domainKey, any()),
        ).thenAnswer((invocation) async => true);

        when(
          () => mockSharedPreferences.setBool(rememberMeKey, any()),
        ).thenAnswer((invocation) async => true);

        //act
        final result = await localLoginDataSourceImpl.saveCredentials(
          (
            name: "test",
            applicationPassword: "test1234",
            domain: "https://example.com",
            rememberMe: true,
          ),
        );

        //assert
        expect(result, isA<LoginCredentialsModel>());
        verify(
          () => mockSharedPreferences.setString(userNameKey, any()),
        ).called(1);
        verify(
          () => mockSharedPreferences.setString(applicationPasswordKey, any()),
        ).called(1);
        verify(
          () => mockSharedPreferences.setString(domainKey, any()),
        ).called(1);
        verify(
          () => mockSharedPreferences.setBool(rememberMeKey, any()),
        ).called(1);
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
        ).thenAnswer((invocation) async => true);

        when(
          () => mockSharedPreferences.setString(domainKey, any()),
        ).thenAnswer((invocation) async => true);
        when(
          () => mockSharedPreferences.setBool(rememberMeKey, any()),
        ).thenAnswer((_) async => false);

        //act
        final result = localLoginDataSourceImpl.saveCredentials(
          (
            name: "test",
            applicationPassword: "test1234",
            domain: "https://example.com",
            rememberMe: true,
          ),
        );

        //assert
        expect(result, throwsA(isA<Exception>()));
      },
    );
  });

  group("getLastCredentials -", () {
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

        when(
          () => mockSharedPreferences.getBool(rememberMeKey),
        ).thenAnswer((_) => true);

        //act
        final userCredentials =
            await localLoginDataSourceImpl.getLastCredentials();

        //assert
        expect(userCredentials, isA<LoginCredentialsModel>());
        expect(userCredentials.userName, "test");
        expect(userCredentials.applicationPassword, "test1234");
        expect(userCredentials.domain, "https://example.com");
        expect(userCredentials.rememberMe, true);

        verify(
          () => mockSharedPreferences.getString(userNameKey),
        ).called(1);
        verify(
          () => mockSharedPreferences.getString(applicationPasswordKey),
        ).called(1);
        verify(
          () => mockSharedPreferences.getString(domainKey),
        ).called(1);
        verify(
          () => mockSharedPreferences.getBool(rememberMeKey),
        ).called(1);
      },
    );
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
        when(
          () => mockSharedPreferences.getBool(rememberMeKey),
        ).thenAnswer((invocation) => true);

        //act
        final result = localLoginDataSourceImpl.getLastCredentials();

        //assert
        expect(result, throwsA(isA<Exception>()));
      },
    );
  });

  group("clearCachedCredentials -", () {
    test("should return (void) when all entries are removed successfully ",
        () async {
      //arrange
      when(
        () => mockSharedPreferences.remove(userNameKey),
      ).thenAnswer((invocation) async => true);
      when(
        () => mockSharedPreferences.remove(applicationPasswordKey),
      ).thenAnswer((invocation) async => true);
      when(
        () => mockSharedPreferences.remove(domainKey),
      ).thenAnswer((invocation) async => true);
      when(
        () => mockSharedPreferences.remove(rememberMeKey),
      ).thenAnswer((invocation) async => true);

      //act
      await localLoginDataSourceImpl.clearCachedCredentials();

      //assert
      verifyAllEntriesCalledToRemove();
    });

    test("should throw (Exception) when some entries are not removed",
        () async {
      //arrange
      when(
        () => mockSharedPreferences.remove(userNameKey),
      ).thenAnswer((invocation) async => true);
      when(
        () => mockSharedPreferences.remove(applicationPasswordKey),
      ).thenAnswer((invocation) async => true);
      when(
        () => mockSharedPreferences.remove(domainKey),
      ).thenAnswer((invocation) async => true);
      when(
        () => mockSharedPreferences.remove(rememberMeKey),
      ).thenAnswer((invocation) async => false);

      //act

      //assert
      expect(localLoginDataSourceImpl.clearCachedCredentials(),
          throwsA(isA<Exception>()));
    });
  });
}
