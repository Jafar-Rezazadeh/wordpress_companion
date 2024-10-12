import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/theme/color_pallet.dart';
import 'package:wordpress_companion/core/utils/validator.dart';
import 'package:wordpress_companion/core/widgets/custom_input_field.dart';
import 'package:wordpress_companion/core/widgets/failure_widget.dart';
import 'package:wordpress_companion/core/widgets/loading_widget.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';
import 'package:wordpress_companion/features/login/presentation/widgets/login_screen/login_header.dart';

import '../../../../core/router/go_router_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _applicationPasswordController =
      TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  bool _rememberMeValue = true;
  bool _obscurePassword = true;

  @override
  void initState() {
    BlocProvider.of<LoginCredentialsCubit>(context).getLastLoginCredentials();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _applicationPasswordController.dispose();
    _domainController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) => _authenticationStateListener(state),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _screenLayout(),
      ),
    );
  }

  _authenticationStateListener(AuthenticationState state) => state.when(
        initial: () => null,
        authenticating: () {
          FocusScope.of(context).unfocus();
          context.loaderOverlay.show();
        },
        authenticationFailed: (failure) {
          context.loaderOverlay.hide();
          _showFailureInModalBottomSheet(failure);
        },
        authenticated: (credentials) {
          context.loaderOverlay.hide();
          context.goNamed(mainScreen, extra: credentials);
          _showSnackBar(content: "ورود با موفقیت انجام شد");
        },
        notValidUser: () {
          context.loaderOverlay.hide();
          _showSnackBar(content: "نام کاربری یا رمز عبور اشتباه است");
        },
      );

  _showFailureInModalBottomSheet(Failure failure) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => FailureWidget(failure: failure),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showSnackBar(
      {required String content}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Scaffold _screenLayout() {
    return Scaffold(
      key: _scaffoldKey,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _contentBuilder(),
      ),
    );
  }

  Widget _contentBuilder() {
    return BlocConsumer<LoginCredentialsCubit, LoginCredentialsState>(
      listener: _loginCredentialsListener,
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          gettingCredentials: () => const Center(child: LoadingWidget()),
          credentialsReceived: (credentials) => _contents(),
          error: (failure) => FailureWidget(failure: failure),
        );
      },
    );
  }

  void _loginCredentialsListener(_, LoginCredentialsState state) {
    state.whenOrNull(
      credentialsReceived: (credentials) {
        _userNameController.text = credentials.userName;
        _applicationPasswordController.text = credentials.applicationPassword;
        _domainController.text = credentials.domain;
        _rememberMeValue = credentials.rememberMe;
      },
    );
  }

  Widget _contents() {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginHeader(headerSize: Size(double.infinity, 0.4.sh)),
            _credentialsForm(),
          ],
        ),
      ),
    );
  }

  Widget _credentialsForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: edgeToEdgePaddingHorizontal,
        vertical: 10,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _userName(),
              _applicationPassword(),
              _rememberMe(),
              _domain(),
              Gap(0.01.sh),
              _submitButton()
            ].withGapInBetween(20),
          ),
        ),
      ),
    );
  }

  Widget _userName() {
    return CustomInputField(
      label: "نام کاربری",
      controller: _userNameController,
      validator: InputValidator.isNotEmpty,
    );
  }

  Widget _applicationPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          controller: _applicationPasswordController,
          obscureText: _obscurePassword,
          validator: InputValidator.isNotEmpty,
          label: "رمز عبور برنامه",
          suffixIcon: _hideOrShowObscurePasswordButton(),
        ),
        const Gap(15),
        _appPasswordHelperText(),
      ],
    );
  }

  IconButton _hideOrShowObscurePasswordButton() {
    return IconButton(
      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      icon: Icon(
        _obscurePassword ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }

  RichText _appPasswordHelperText() {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: "نحوه ایجاد رمز عبور برنامه",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorPallet.midBlue,
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _showHelperDialog();
              },
          ),
        ],
      ),
    );
  }

  void _showHelperDialog() {
    showDialog(
      context: context,
      builder: (context) => const Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SingleChildScrollView(
              child: AppPasswordCreationSteps(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _rememberMe() {
    return Row(
      children: [
        Checkbox(
          value: _rememberMeValue,
          splashRadius: 0,
          onChanged: (value) =>
              setState(() => _rememberMeValue = value ?? _rememberMeValue),
        ),
        const Text("مرا به خاطر بسپار"),
      ],
    );
  }

  Widget _domain() {
    return CustomInputField(
      controller: _domainController,
      validator: InputValidator.isNotEmpty,
      textDirection: TextDirection.ltr,
      label: "دامنه",
      hintText: "مثال: https://example.com",
    );
  }

  Widget _submitButton() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 55),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: ColorPallet.midBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(smallCornerRadius),
          ),
        ),
        onPressed: () => ifFieldsValid() ? login() : null,
        child: const Text("ورود", style: TextStyle(fontSize: 20)),
      ),
    );
  }

  bool ifFieldsValid() => _formKey.currentState?.validate() == true;

  login() {
    BlocProvider.of<AuthenticationCubit>(context).loginAndSave(
      (
        name: _userNameController.text,
        applicationPassword: _applicationPasswordController.text,
        domain: _domainController.text,
        rememberMe: _rememberMeValue,
      ),
    );
  }
}
