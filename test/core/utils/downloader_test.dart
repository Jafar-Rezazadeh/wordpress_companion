import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel downloaderChannel = MethodChannel("vn.hunghd/downloader");

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(downloaderChannel,
            (MethodCall methodCall) async {
      if (methodCall.method == "initialize") {
        return true;
      }
      return null;
    });
    FlutterDownloader.initialize();
  });

  test("should return an taskID as (String) when success", () async {
    //arrange
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      downloaderChannel,
      (message) async {
        if (message.method == "enqueue") {
          return "taskId1";
        }
        return null;
      },
    );

    //act
    final taskId = await Downloader.test().downloadFile(
      url: "test",
      fileFullName: "filename",
    );

    //assert
    expect(taskId, "taskId1");
  });

  test(
      "should create call real method channel when Downloader() constructor used",
      () {
    //act
    final result =
        Downloader().downloadFile(url: "url", fileFullName: "fileFullName");

    //assert
    expect(result, throwsAssertionError);
  });
}
