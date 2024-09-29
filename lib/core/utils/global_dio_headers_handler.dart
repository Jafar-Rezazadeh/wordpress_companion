import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../constants/constants.dart';

class GlobalDioHeadersHandler {
  final GetIt _getIt;

  GlobalDioHeadersHandler({required GetIt getItInstance}) : _getIt = getItInstance;

  setAuthorization({required String username, required String password}) {
    _getIt.get<Dio>().options.headers.addAll(
      {
        "Authorization": makeBase64Encode(name: username, password: password),
      },
    );
  }

  setBaseUrl(String domain) {
    _getIt.get<Dio>().options.baseUrl = domain;
  }
}
