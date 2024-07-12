import 'package:flutter/material.dart';

class AppPasswordCreationSteps extends StatelessWidget {
  const AppPasswordCreationSteps({super.key});

  @override
  Widget build(BuildContext context) {
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
                    text:
                        "کاربر مورد نظر را انتخاب کنید و ویرایش کاربر را بزنید، توجه کاربر انتخابی باید توانایی دسترسی کامل داشته باشد"
                        "\n\n\n",
                  ),
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
}
