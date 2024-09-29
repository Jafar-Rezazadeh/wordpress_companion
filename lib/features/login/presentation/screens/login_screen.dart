import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/utils/validator.dart';
import 'package:wordpress_companion/core/widgets/failure_widget.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double eachFieldPadding = 30;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _userNameController;
  late TextEditingController _applicationPasswordController;
  late TextEditingController _domainController;
  bool _rememberMeValue = true;
  bool _obscurePassword = true;

  @override
  void initState() {
    _initControllers();
    super.initState();
  }

  _initControllers() async {
    _userNameController = TextEditingController();
    _applicationPasswordController = TextEditingController();
    _domainController = TextEditingController();
    await _setLastLoginCredentials();
  }

  Future<void> _setLastLoginCredentials() async {
    //TODO: use need cubit to get last login credentials
    final lastLoginCredentials = await context.read<LoginCubit>().getLastLoginCredentials();

    if (lastLoginCredentials != null) {
      setState(() {
        _userNameController.text = lastLoginCredentials.userName;
        _applicationPasswordController.text = lastLoginCredentials.applicationPassword;
        _domainController.text = lastLoginCredentials.domain;
      });
    }
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
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) => _stateChangeListener(state),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _screenLayout(),
      ),
    );
  }

  _stateChangeListener(LoginState state) => state.when(
        initial: () => null,
        loggingIn: () {
          FocusScope.of(context).unfocus();
          context.loaderOverlay.show();
        },
        loginFailed: (failure) {
          context.loaderOverlay.hide();
          _showFailureInModalBottomSheet(failure);
        },
        loginSuccess: (credentials) {
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
        child: _scrollableContainer(),
      ),
    );
  }

  Widget _scrollableContainer() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(30),
            _title(),
            const Gap(30),
            _subTitle(),
            const Gap(10),
            _credentialsForm(),
            _rememberMe(),
            const Gap(30),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      "وردپرس یار",
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: const Color.fromARGB(255, 28, 45, 141)),
    );
  }

  Widget _subTitle() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "ورود به حساب کاربری وردپرس",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _credentialsForm() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _userName(),
            const Gap(10),
            _applicationPassword(),
            const Gap(10),
            _domain(),
          ],
        ),
      ),
    );
  }

  Material _userName() {
    return _textFieldLayout(
      child: TextFormField(
        controller: _userNameController,
        validator: InputValidator.isNotEmpty,
        decoration: const InputDecoration(
          border: InputBorder.none,
          label: Text("نام کاربری"),
        ),
      ),
    );
  }

  Material _textFieldLayout({required Widget child}) {
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.all(Radius.circular(eachFieldPadding)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: child,
      ),
    );
  }

  Widget _applicationPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldLayout(
          child: TextFormField(
            controller: _applicationPasswordController,
            obscureText: _obscurePassword,
            validator: InputValidator.isNotEmpty,
            decoration: InputDecoration(
              border: InputBorder.none,
              label: const Text("رمز عبور برنامه"),
              suffixIcon: _hideOrShowObscurePasswordButton(),
            ),
          ),
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
            text: "برای آموزش ساخت رمز عبور برنامه در وردپرس ",
            children: [
              _tapGestureText(),
              const TextSpan(
                text: " ضربه بزنید.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextSpan _tapGestureText() {
    return TextSpan(
      text: "اینجا",
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          _showHelperDialog();
        },
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

  Widget _domain() {
    return _textFieldLayout(
      child: TextFormField(
        controller: _domainController,
        validator: InputValidator.isNotEmpty,
        textDirection: TextDirection.ltr,
        decoration: const InputDecoration(
          border: InputBorder.none,
          label: Text("دامنه"),
          hintText: "مثال: https://example.com",
        ),
      ),
    );
  }

  Widget _rememberMe() {
    return Align(
      alignment: Alignment.centerRight,
      child: CheckboxListTile(
        title: const Text("مرا به خاطر بسپار"),
        value: _rememberMeValue,
        onChanged: (value) {
          setState(() {
            _rememberMeValue = value ?? _rememberMeValue;
          });
        },
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(padding: EdgeInsets.all(eachFieldPadding - 10)),
        onPressed: () => _ifFieldsValid() ? _makeLogin() : null,
        child: const Text("ورود"),
      ),
    );
  }

  bool _ifFieldsValid() => _formKey.currentState?.validate() == true;

  _makeLogin() {
    BlocProvider.of<LoginCubit>(context).loginAndSave(
      (
        name: _userNameController.text,
        applicationPassword: _applicationPasswordController.text,
        domain: _domainController.text,
        rememberMe: _rememberMeValue,
      ),
    );
  }
}
