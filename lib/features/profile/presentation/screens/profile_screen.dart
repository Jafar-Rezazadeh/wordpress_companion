import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/widgets/pushed_page_app_bar.dart';
import 'package:wordpress_companion/core/widgets/save_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        SaveButton(onPressed: () {}),
      ],
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
          child: Column(
            children: [
              _header(),
              const Gap(30),
              _formContents(),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 70,
        ),
        Text(
          "جعفر رضازاده",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.black),
        ),
        Text("ادمین", style: Theme.of(context).textTheme.titleMedium),
      ].withGapInBetween(5),
    );
  }

  Widget _formContents() {
    return Form(
      child: Column(
        children: [
          const CustomFormInputField(label: "نام کاربری"),
          const CustomFormInputField(label: "نام نمایشی"),
          const CustomFormInputField(label: "نام"),
          const CustomFormInputField(label: "نام خانوادگی"),
          const CustomFormInputField(
            label: "ایمیل",
            //TODO: validate email
          ),
          const CustomFormInputField(label: "نامک"),
          const CustomFormInputField(label: "لقب"),
          const CustomFormInputField(label: "وب سایت"),
          const CustomFormInputField(
            label: "توضیحات",
            maxLines: 4,
          ),
        ].withGapInBetween(25),
      ),
    );
  }
}
