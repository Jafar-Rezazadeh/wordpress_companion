import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/utils/http_status_helper.dart';

import '../errors/failures.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure;
  const FailureWidget({super.key, required this.failure});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(minHeight: 300),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: _showBasedOnFailure(),
        ),
      ),
    );
  }

  Widget _showBasedOnFailure() {
    switch (failure) {
      case ServerFailure serverFailure:
        return _showServerFailureMessage(serverFailure);
      case UnknownFailure unknownFailure:
        return _showUnknownFailureMessage(unknownFailure);
      default:
        return const Text("UnknownFailure");
    }
  }

  Widget _showServerFailureMessage(ServerFailure failure) {
    return Column(
      children: [
        const Text("خطای سرور"),
        const Gap(10),
        Text("کد: " "${failure.response?.statusCode ?? "0"}"),
        const Gap(10),
        _responseMessage(failure),
        const Gap(10),
        _dioInformation(failure),
      ],
    );
  }

  Widget _dioInformation(ServerFailure failure) {
    return ExpansionTile(
      title: const Text("اطلاعات ارتباط با سرور"),
      children: [
        Text(
          failure.message,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _responseMessage(ServerFailure failure) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          HttpStatusHelper(status: failure.response?.statusCode ?? 0).translateToMessage(),
        ),
        const Gap(5),
        Text(
          "پیام از سمت سرور: " "${failure.response?.data['message'] ?? "نامعلوم"}",
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _showUnknownFailureMessage(UnknownFailure unknownFailure) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("خطای ناشناخته"),
        const Gap(10),
        Text(unknownFailure.message),
        const Gap(10),
        Text(
          unknownFailure.stackTrace.toString().length >= 300
              ? unknownFailure.stackTrace.toString().substring(0, 300)
              : unknownFailure.stackTrace.toString(),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
