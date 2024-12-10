import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../../../../core/utils/enum_translator.dart';

import '../../profile_exports.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _paramsBuilder = UpdateMyProfileParamsBuilder();
  late final ProfileController profileController;

  UpdateMyProfileParamsBuilder get paramsBuilder => _paramsBuilder;

  @override
  Widget build(BuildContext context) {
    profileController = Get.find<ProfileController>();

    return Scaffold(
      appBar: _appBar(context),
      body: _bodyLayout(),
    );
  }

  PushedScreenAppBar _appBar(BuildContext context) {
    return PushedScreenAppBar(
      context: context,
      title: "پروفایل",
      bottomLeadingWidgets: [
        Obx(
          () => SaveButton(
            key: const Key("submit_button"),
            onPressed: !profileController.currentStatus.isLoading
                ? _performSubmitAction
                : null,
          ),
        ),
      ],
    );
  }

  _performSubmitAction() {
    if (_inputsAreValid()) {
      profileController.updateMyProfile(_paramsBuilder.build());
    }
  }

  bool _inputsAreValid() =>
      _formKey.currentState != null && _formKey.currentState!.validate();

  Widget _bodyLayout() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: edgeToEdgePaddingHorizontal,
          ),
          child: profileGetBuilder(),
        ),
      ),
    );
  }

  Widget profileGetBuilder() {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        if (controller.status.isLoading == true) {
          return _loading();
        }
        _showFailureBottomSheetOnError(controller.status);

        _setInitialProfileData();

        return _contents();
      },
    );
  }

  void _showFailureBottomSheetOnError(RxStatus status) {
    if (status.isError == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.isBottomSheetOpen == true) {
          Get.back();
        }
        Get.bottomSheet(
          FailureWidget(
            failure: profileController.failure ??
                const InternalFailure(
                  message: "unknown",
                  stackTrace: StackTrace.empty,
                ),
          ),
          backgroundColor: Colors.white,
          exitBottomSheetDuration: Durations.medium1,
          enterBottomSheetDuration: Durations.medium1,
        );
      });
    }
  }

  void _setInitialProfileData() {
    _paramsBuilder.setFromInitialData(profileController.profileData);
  }

  Padding _loading() {
    return const Padding(
      padding: EdgeInsets.only(top: 100),
      child: LoadingWidget(),
    );
  }

  Widget _contents() {
    return Column(
      key: const Key("contents_key"),
      children: [
        _header(),
        const Gap(30),
        _formContents(),
        const Gap(50),
      ],
    );
  }

  Widget _header() {
    return Column(
      children: [
        _avatar(),
        _fullName(),
        _role(),
      ].withGapInBetween(5),
    );
  }

  Widget _avatar() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: ColorPallet.border),
      ),
      padding: const EdgeInsets.all(2),
      height: 120,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          profileController.profileData?.avatarUrls.size96px ?? "",
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Text _fullName() {
    return Text(
      "${profileController.profileData?.firstName} ${profileController.profileData?.lastName}",
      style: Get.textTheme.titleLarge?.copyWith(color: Colors.black),
    );
  }

  Text _role() {
    return Text(
      profileController.profileData?.roles
              .map((e) => EnumTranslator.translateUserRole(e))
              .join(", ") ??
          "",
      style: Get.textTheme.titleMedium,
    );
  }

  Widget _formContents() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomFormInputField(
            label: "نام کاربری",
            initialValue: profileController.profileData?.userName,
            enabled: false,
            helperText: "نام کاربری قابل تغییر نیست.",
          ),
          CustomFormInputField(
            label: "نام نمایشی",
            initialValue: profileController.profileData?.name,
            onChanged: (value) => _paramsBuilder.setName(value),
          ),
          CustomFormInputField(
            label: "نام",
            initialValue: profileController.profileData?.firstName,
            onChanged: (value) => _paramsBuilder.setFirstName(value),
          ),
          CustomFormInputField(
            label: "نام خانوادگی",
            initialValue: profileController.profileData?.lastName,
            onChanged: (value) => _paramsBuilder.setLastName(value),
          ),
          CustomFormInputField(
            key: const Key("email_input"),
            label: "ایمیل",
            initialValue: profileController.profileData?.email,
            focusNode: _emailFocusNode,
            validator: (value) {
              final isValid = InputValidator.isValidEmail(value);
              if (isValid != null) {
                _emailFocusNode.requestFocus();
              }
              return isValid;
            },
            onChanged: (value) => _paramsBuilder.setEmail(value),
          ),
          CustomFormInputField(
            label: "نامک",
            initialValue: profileController.profileData?.slug,
            onChanged: (value) => _paramsBuilder.setSlug(value),
          ),
          CustomFormInputField(
            label: "لقب",
            initialValue: profileController.profileData?.nickName,
            onChanged: (value) => _paramsBuilder.setNickname(value),
          ),
          CustomFormInputField(
            label: "وب سایت",
            initialValue: profileController.profileData?.url,
            onChanged: (value) => _paramsBuilder.setUrl(value),
          ),
          CustomFormInputField(
            label: "توضیحات",
            initialValue: profileController.profileData?.description,
            onChanged: (value) => _paramsBuilder.setDescription(value),
            maxLines: 4,
          ),
        ].withGapInBetween(30),
      ),
    );
  }
}
