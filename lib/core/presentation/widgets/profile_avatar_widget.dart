import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../core_export.dart';
import '../../../features/profile/profile_exports.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final double? radius;
  const ProfileAvatarWidget({super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key("profile_avatar"),
      onTap: () => Get.toNamed(profileScreenRoute),
      child: _avatarBuilder(),
    );
  }

  Widget _avatarBuilder() {
    return BlocBuilder<GlobalProfileCubit, GlobalProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => const LoadingWidget(),
          loaded: (profile) => _renderAvatarWidget(profile),
          error: (failure) => _errorWidget(),
        );
      },
    );
  }

  Widget _renderAvatarWidget(ProfileEntity profile) {
    return CircleAvatar(
      key: const Key("avatar_widget"),
      foregroundImage: NetworkImage(profile.avatarUrls.size96px),
      onForegroundImageError: (exception, stackTrace) {},
      maxRadius: radius,
      child: const Icon(Icons.person),
    );
  }

  Container _errorWidget() {
    return Container(
      key: const Key("error_avatar_widget"),
      child: const Icon(Icons.error),
    );
  }
}
