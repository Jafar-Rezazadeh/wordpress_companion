import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/utils/enum_translator.dart';
import 'package:wordpress_companion/core/widgets/pushed_page_app_bar.dart';
import 'package:wordpress_companion/core/widgets/save_button.dart';

import '../../profile_exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final emailFocusNode = FocusNode();
  bool isLoading = false;
  ProfileAvatarUrlsEntity? avatarUrls;
  String userName = "";
  String nameValue = "";
  String firstNameValue = "";
  String lastNameValue = "";
  String emailValue = "";
  String urlValue = "";
  String descriptionValue = "";
  String nickNameValue = "";
  String slugValue = "";
  List<UserRole> userRoles = [];

  @override
  void initState() {
    context.read<ProfileCubit>().getMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodyLayout(),
    );
  }

  PushedPageAppBar _appBar() {
    return PushedPageAppBar(
      context: context,
      bottomActionWidgets: [
        SaveButton(
          key: const Key("submit_button"),
          onPressed: _isLoadedState()
              ? () {
                  if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    _callCubitToUpdate();
                  }
                }
              : null,
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

  void _callCubitToUpdate() {
    context.read<ProfileCubit>().updateProfile(
          UpdateMyProfileParams(
            displayName: nameValue,
            firstName: firstNameValue,
            lastName: lastNameValue,
            email: emailValue,
            url: urlValue,
            description: descriptionValue,
            nickName: nickNameValue,
            slug: slugValue,
          ),
        );
  }

  Widget _bodyLayout() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: edgeToEdgePaddingHorizontal,
          ),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: _profileStateListener,
            builder: (context, state) {
              return state.when(
                initial: () => Container(),
                loading: () => const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: LoadingWidget(),
                ),
                loaded: (profile) => _contents(),
                error: (failure) => FailureWidget(failure: failure),
              );
            },
          ),
        ),
      ),
    );
  }

  void _profileStateListener(BuildContext _, ProfileState state) {
    state.whenOrNull(
      loaded: (profile) => setState(() {
        userRoles = profile.roles;
        avatarUrls = profile.avatarUrls;
        userName = profile.userName;
        nameValue = profile.name;
        firstNameValue = profile.firstName;
        lastNameValue = profile.lastName;
        emailValue = profile.email;
        urlValue = profile.url;
        descriptionValue = profile.description;
        nickNameValue = profile.nickName;
        slugValue = profile.slug;
      }),
    );
  }

  Widget _contents() {
    return Column(
      key: const Key("contents_key"),
      children: [
        _header(),
        const Gap(30),
        _formContents(),
        const Gap(500),
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
          avatarUrls?.size96px ?? "",
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
      "$firstNameValue $lastNameValue",
      style:
          Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
    );
  }

  Text _role() {
    return Text(
      userRoles.map((e) => EnumTranslator.translateUserRole(e)).join(", "),
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
            initialValue: userName,
            enabled: false,
            helperText: "نام کاربری قابل تغییر نیست.",
          ),
          CustomFormInputField(
            label: "نام نمایشی",
            initialValue: nameValue,
            onChanged: (value) => nameValue = value,
          ),
          CustomFormInputField(
            label: "نام",
            initialValue: firstNameValue,
            onChanged: (value) => firstNameValue = value,
          ),
          CustomFormInputField(
            label: "نام خانوادگی",
            initialValue: lastNameValue,
            onChanged: (value) => lastNameValue = value,
          ),
          CustomFormInputField(
            key: const Key("email_input"),
            label: "ایمیل",
            initialValue: emailValue,
            focusNode: emailFocusNode,
            validator: (value) {
              final isValid = InputValidator.isValidEmail(value);
              if (isValid != null) {
                emailFocusNode.requestFocus();
              }
              return isValid;
            },
            onChanged: (value) => emailValue = value,
          ),
          CustomFormInputField(
            label: "نامک",
            initialValue: slugValue,
            onChanged: (value) => slugValue = value,
          ),
          CustomFormInputField(
            label: "لقب",
            initialValue: nickNameValue,
            onChanged: (value) => nickNameValue = value,
          ),
          CustomFormInputField(
            label: "وب سایت",
            initialValue: urlValue,
            onChanged: (value) => urlValue = value,
          ),
          CustomFormInputField(
            label: "توضیحات",
            initialValue: descriptionValue,
            onChanged: (value) => descriptionValue = value,
            maxLines: 4,
          ),
        ].withGapInBetween(25),
      ),
    );
  }
}
