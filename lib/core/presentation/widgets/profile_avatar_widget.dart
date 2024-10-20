import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/entities/profile_avatar.dart';

import '../../errors/failures.dart';
import '../../router/go_router_config.dart';
import '../../services/profile_service.dart';

class ProfileAvatarWidget extends StatefulWidget {
  const ProfileAvatarWidget({super.key});

  @override
  State<ProfileAvatarWidget> createState() => _ProfileAvatarWidgetState();
}

class _ProfileAvatarWidgetState extends State<ProfileAvatarWidget> {
  Future<Either<Failure, ProfileAvatar>>? getAvatarFuture;

  @override
  void initState() {
    _getAvatar();
    super.initState();
  }

  _getAvatar() {
    getAvatarFuture = GetIt.instance.get<ProfileService>().getProfileAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key("profile_avatar"),
      onTap: () => context.goNamed(profileScreen),
      child: _avatarBuilder(),
    );
  }

  Widget _avatarBuilder() {
    return FutureBuilder(
      future: getAvatarFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return _renderAvatarWidget(snapshot.data);
        }
      },
    );
  }

  Widget _renderAvatarWidget(Either<Failure, ProfileAvatar>? data) {
    return CircleAvatar(
      radius: 20,
      foregroundImage: _avatarImage(data),
      onForegroundImageError: (exception, stackTrace) {},
      child: const Icon(Icons.person),
    );
  }

  ImageProvider _avatarImage(Either<Failure, ProfileAvatar>? data) {
    return NetworkImage(
      data?.fold((l) => " ", (r) => r.size96px) ?? " ",
    );
  }
}
