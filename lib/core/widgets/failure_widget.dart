import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/http_status_helper.dart';

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
    if (failure is ServerFailure) {
      return _showServerFailureMessage(failure as ServerFailure);
    } else {
      return _showInternalFailureMessage(failure as InternalFailure);
    }
  }

  Widget _showServerFailureMessage(ServerFailure failure) {
    return Container(
      key: const Key("server_failure"),
      child: Column(
        children: [
          const Text("خطای سرور"),
          const Gap(10),
          Text("کد: " "${failure.response?.statusCode ?? "0"}"),
          const Gap(10),
          _responseMessage(failure),
          const Gap(10),
          _dioInformation(failure),
        ],
      ),
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
          "پیام از سمت سرور: " "${_getMessage(failure) ?? "نامعلوم"}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Gap(5),
        Text(
          HttpStatusHelper.translateToMessage(
              failure.response?.statusCode ?? 0),
        ),
      ],
    );
  }

  _getMessage(ServerFailure failure) {
    try {
      return failure.response?.data['message'];
    } catch (e) {
      return failure.response;
    }
  }

  Widget _showInternalFailureMessage(InternalFailure failure) {
    return Container(
      key: const Key("internal_failure"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Internal Failure"),
          const Gap(10),
          Text(failure.message),
          const Gap(10),
          ExpansionTile(
            title: const Text("اطلاعات بیشتر"),
            children: [
              Text(
                failure.stackTrace.toString(),
                textAlign: TextAlign.left,
              ),
            ],
          )
        ],
      ),
    );
  }
}
