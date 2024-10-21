import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../../router/go_router_config.dart';
import '../cubits/global_profile_cubit/global_profile_cubit.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final double? radius;
  const ProfileAvatarWidget({super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key("profile_avatar"),
      onTap: () => context.goNamed(profileScreen),
      child: _avatarBuilder(),
    );
  }

  // TODO: improve test coverage
  Widget _avatarBuilder() {
    return BlocBuilder<GlobalProfileCubit, GlobalProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => const LoadingWidget(),
          loaded: (profile) => _renderAvatarWidget(profile),
          error: (failure) => Container(),
        );
      },
    );
  }

  Widget _renderAvatarWidget(ProfileEntity profile) {
    return CircleAvatar(
      foregroundImage: NetworkImage(profile.avatarUrls.size96px),
      onForegroundImageError: (exception, stackTrace) {},
      maxRadius: radius,
      child: const Icon(Icons.person),
    );
  }
}
