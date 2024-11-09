import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import '../../../../core/core_export.dart';
import '../../../../core/utils/enum_translator.dart';

import '../../profile_exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode();
  final paramsBuilder = UpdateMyProfileParamsBuilder();
  ProfileEntity? initialProfileData;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodyLayout(),
    );
  }

  PushedScreenAppBar _appBar() {
    return PushedScreenAppBar(
      context: context,
      bottomLeadingWidgets: [
        SaveButton(
          key: const Key("submit_button"),
          onPressed: _isLoadedState() ? _performSubmitAction : null,
        ),
      ],
    );
  }

  bool _isLoadedState() {
    return context
        .watch<ProfileCubit>()
        .state
        .maybeWhen(loaded: (_) => true, orElse: () => false);
  }

  _performSubmitAction() {
    if (_inputsAreValid()) {
      context.read<ProfileCubit>().updateProfile(paramsBuilder.build());
    }
  }

  bool _inputsAreValid() =>
      formKey.currentState != null && formKey.currentState!.validate();

  Widget _bodyLayout() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: edgeToEdgePaddingHorizontal,
          ),
          child: _profileStateBuilder(),
        ),
      ),
    );
  }

  BlocConsumer<ProfileCubit, ProfileState> _profileStateBuilder() {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: _profileStateListener,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => _loading(),
          orElse: () => _contents(),
        );
      },
    );
  }

  Padding _loading() {
    return const Padding(
      padding: EdgeInsets.only(top: 100),
      child: LoadingWidget(),
    );
  }

  void _profileStateListener(BuildContext _, ProfileState state) {
    state.whenOrNull(
      loaded: (profile) {
        initialProfileData = profile;
        paramsBuilder.setFromInitialData(profile);
      },
      error: (failure) => CustomBottomSheets.showFailureBottomSheet(
        context: context,
        failure: failure,
      ),
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
          initialProfileData?.avatarUrls.size96px ?? "",
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
      "${initialProfileData?.firstName} ${initialProfileData?.lastName}",
      style:
          Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
    );
  }

  Text _role() {
    return Text(
      initialProfileData?.roles
              .map((e) => EnumTranslator.translateUserRole(e))
              .join(", ") ??
          "",
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _formContents() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomFormInputField(
            label: "نام کاربری",
            initialValue: initialProfileData?.userName,
            enabled: false,
            helperText: "نام کاربری قابل تغییر نیست.",
          ),
          CustomFormInputField(
            label: "نام نمایشی",
            initialValue: initialProfileData?.name,
            onChanged: (value) => paramsBuilder.setName(value),
          ),
          CustomFormInputField(
            label: "نام",
            initialValue: initialProfileData?.firstName,
            onChanged: (value) => paramsBuilder.setFirstName(value),
          ),
          CustomFormInputField(
            label: "نام خانوادگی",
            initialValue: initialProfileData?.lastName,
            onChanged: (value) => paramsBuilder.setLastName(value),
          ),
          CustomFormInputField(
            key: const Key("email_input"),
            label: "ایمیل",
            initialValue: initialProfileData?.email,
            focusNode: emailFocusNode,
            validator: (value) {
              final isValid = InputValidator.isValidEmail(value);
              if (isValid != null) {
                emailFocusNode.requestFocus();
              }
              return isValid;
            },
            onChanged: (value) => paramsBuilder.setEmail(value),
          ),
          CustomFormInputField(
            label: "نامک",
            initialValue: initialProfileData?.slug,
            onChanged: (value) => paramsBuilder.setSlug(value),
          ),
          CustomFormInputField(
            label: "لقب",
            initialValue: initialProfileData?.nickName,
            onChanged: (value) => paramsBuilder.setNickname(value),
          ),
          CustomFormInputField(
            label: "وب سایت",
            initialValue: initialProfileData?.url,
            onChanged: (value) => paramsBuilder.setUrl(value),
          ),
          CustomFormInputField(
            label: "توضیحات",
            initialValue: initialProfileData?.description,
            onChanged: (value) => paramsBuilder.setDescription(value),
            maxLines: 4,
          ),
        ].withGapInBetween(30),
      ),
    );
  }
}
