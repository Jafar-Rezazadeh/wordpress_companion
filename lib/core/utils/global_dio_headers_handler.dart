import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'encoder.dart';

class GlobalDioHeadersHandler {
  final GetIt _getIt;

  GlobalDioHeadersHandler({required GetIt getItInstance})
      : _getIt = getItInstance;

  setAuthorization({required String username, required String password}) {
    _getIt.allowReassignment = true;

    _getIt.get<Dio>().options.headers.addAll(
      {
        "Authorization":
            CustomEncoder.base64Encode(name: username, password: password),
      },
    );

    _getIt.allowReassignment = false;
  }

  setBaseUrl(String domain) {
    _getIt.allowReassignment = true;

    _getIt.get<Dio>().options.baseUrl = domain;

    _getIt.allowReassignment = false;
  }
}
