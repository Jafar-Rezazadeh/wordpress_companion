import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/utils/validator.dart';
import 'package:wordpress_companion/features/user-login/presentation/logic_holder/login_cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final double eachFieldPadding = 30;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _applicationPasswordController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(20),
                  _title(),
                  const Gap(40),
                  _littleInfo(),
                  const Gap(20),
                  _credentialsForm(),
                  const Gap(40),
                  _submit(),
                ],
              ),
            ),
          ),
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

  Widget _littleInfo() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "ورود به حساب کاربری",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _credentialsForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _userName(),
          const Gap(20),
          _applicationPassword(),
          const Gap(10),
          _domain(),
        ],
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
            validator: InputValidator.isNotEmpty,
            decoration: const InputDecoration(
              border: InputBorder.none,
              label: Text("رمز عبور برنامه"),
            ),
          ),
        ),
        const Gap(15),
        _appPasswordHelper(),
      ],
    );
  }

  RichText _appPasswordHelper() {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: "برای آموزش ساخت رمز عبور برنامه در وردپرس ",
            children: [
              TextSpan(
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
              ),
              const TextSpan(
                text: " ضربه بزنید.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showHelperDialog() {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SingleChildScrollView(
              child: _stepsOfCreatingAppPassword(),
            ),
          ),
        ),
      ),
    );
  }

  Column _stepsOfCreatingAppPassword() {
    return const Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "*مهم*" "\n",
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "برای استفاده از این ویژگی نسخه وردپرس باید بالای 5.6 باشد."
                        "\n\n\n",
                  ),
                ],
              ),
              TextSpan(
                text: "1) ",
                children: [
                  TextSpan(text: "در داشبورد وردپرس وارد بخش کاربران شوید" "\n\n\n"),
                ],
              ),
              TextSpan(
                text: "2) ",
                children: [
                  TextSpan(
                      text: "کاربر مورد نظر را انتخاب کنید و ویرایش کاربر را بزنید"
                          "\n\n\n"),
                ],
              ),
              TextSpan(
                text: "3) ",
                children: [
                  TextSpan(
                    text: "در بخش ویرایش کاربر گزینه رمز های عبور برنامه را پیدا کنید"
                        "\n\n\n",
                  ),
                ],
              ),
              TextSpan(
                text: "4) ",
                children: [
                  TextSpan(
                    text:
                        "یک نام برای رمز عبور برنامه وارد کنید و دکمه افزودن رمز عبور برنامه جدید را بزنید"
                        "\n\n\n",
                  ),
                ],
              ),
              TextSpan(
                text: "5) ",
                children: [
                  TextSpan(
                    text: "رمز عبور برنامه را کپی و در نرم افزار وارد کنید"
                        "\n\n\n",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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

  Widget _submit() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          padding: EdgeInsets.all(eachFieldPadding - 10),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            BlocProvider.of<LoginCubit>(context).login(
              (
                name: _userNameController.text,
                applicationPassword: _applicationPasswordController.text,
                domain: _domainController.text,
              ),
            );
          }
        },
        child: const Text("ورود"),
      ),
    );
  }
}
