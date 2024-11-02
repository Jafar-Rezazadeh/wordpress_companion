import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/contracts/use_case.dart';
import '../../../profile_exports.dart';

import '../../../../../core/errors/failures.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetMyProfile _getMyProfile;
  final UpdateMyProfile _updateMyProfile;

  ProfileCubit({
    required GetMyProfile getMyProfile,
    required UpdateMyProfile updateMyProfile,
  })  : _getMyProfile = getMyProfile,
        _updateMyProfile = updateMyProfile,
        super(const ProfileState.initial());

  getMyProfile() async {
    emit(const ProfileState.loading());

    final result = await _getMyProfile(NoParams());

    result.fold(
      (failure) => emit(ProfileState.error(failure)),
      (profile) => emit(ProfileState.loaded(profile)),
    );
  }

  updateProfile(UpdateMyProfileParams params) async {
    emit(const ProfileState.loading());

    final result = await _updateMyProfile(params);

    result.fold(
      (failure) => emit(ProfileState.error(failure)),
      (profile) => emit(ProfileState.loaded(profile)),
    );
  }
}
