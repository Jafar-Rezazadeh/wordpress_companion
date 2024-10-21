import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/presentation/widgets/profile_avatar_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _header(),
        ],
      ),
    );
  }

  Widget _header() {
    return BlocBuilder<GlobalProfileCubit, GlobalProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => const LoadingWidget(),
          loaded: (profile) => UserAccountsDrawerHeader(
            accountName: Text("${profile.firstName} ${profile.lastName}"),
            accountEmail: Text(profile.email),
            currentAccountPicture: const ProfileAvatarWidget(),
          ),
          error: (failure) => ErrorWidget(failure),
        );
      },
    );
  }
}
