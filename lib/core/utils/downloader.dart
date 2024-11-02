import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:uuid/v4.dart';

class Downloader {
  String? _tempPath;

  Downloader();

  Downloader.test() {
    _tempPath = Directory.systemTemp.path;
  }

  /// [fileFullName] is the name of the file + extension like "image.jpg"
  Future<String?> downloadFile(
      {required String url, required String fileFullName}) async {
    return await FlutterDownloader.enqueue(
      url: url,
      savedDir: _tempPath ?? "/storage/emulated/0/Download/",
      openFileFromNotification: true,
      saveInPublicStorage: true,
      requiresStorageNotLow: true,
      showNotification: true,
      fileName: "${const UuidV4().generate()}-$fileFullName",
    );
  }
}
