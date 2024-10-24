import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/utils/custom_url_launcher.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/url_launcher');

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    // Clear the mock after the test
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
  group("openInBrowser -", () {
    test("should return (True) when launched url", () async {
      //arrange
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'launch') {
          return true; // Simulate successful launch
        }
        return null;
      });
      final launcher = CustomUrlLauncher();

      //act
      final result = await launcher.openInBrowser("https://google.com");

      //assert
      expect(result, true);
    });

    test("should return (false) when fails to launch", () async {
      //arrange
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'launch') {
          return false; // Simulate successful launch
        }
        return null;
      });
      final launcher = CustomUrlLauncher();

      //act
      final result = await launcher.openInBrowser("56421dfs");

      //assert
      expect(result, false);
    });
  });
}
