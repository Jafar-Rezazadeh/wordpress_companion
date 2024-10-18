import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/widgets/pushed_page_app_bar.dart';
import 'package:wordpress_companion/core/widgets/save_button.dart';

import '../../profile_exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileEntity? profile;

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
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: _profileStateListener,
            builder: (context, state) {
              return state.when(
                initial: () => Container(),
                loading: () => const LoadingWidget(),
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
      loaded: (profile) => setState(() => this.profile = profile),
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
        const CircleAvatar(
          radius: 70,
        ),
        _fullName(),
        _role(),
      ].withGapInBetween(5),
    );
  }

  Text _fullName() {
    return Text(
      "جعفر رضازاده",
      style:
          Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
    );
  }

  Text _role() => Text("ادمین", style: Theme.of(context).textTheme.titleMedium);

  Widget _formContents() {
    return Form(
      child: Column(
        children: [
          CustomFormInputField(
            label: "نام کاربری",
            initialValue: profile?.userName,
            enabled: false,
          ),
          CustomFormInputField(
            label: "نام نمایشی",
            initialValue: profile?.name,
          ),
          CustomFormInputField(
            label: "نام",
            initialValue: profile?.firstName,
          ),
          CustomFormInputField(
            label: "نام خانوادگی",
            initialValue: profile?.lastName,
          ),
          CustomFormInputField(
            label: "ایمیل",
            initialValue: profile?.email,
            //TODO: validate email
          ),
          CustomFormInputField(
            label: "نامک",
            initialValue: profile?.slug,
          ),
          CustomFormInputField(
            label: "لقب",
            initialValue: profile?.nickName,
          ),
          CustomFormInputField(
            label: "وب سایت",
            initialValue: profile?.url,
          ),
          CustomFormInputField(
            label: "توضیحات",
            initialValue: profile?.description,
            maxLines: 4,
          ),
        ].withGapInBetween(25),
      ),
    );
  }
}
