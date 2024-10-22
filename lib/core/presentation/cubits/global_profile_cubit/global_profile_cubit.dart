import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../errors/failures.dart';

import '../../../../features/profile/profile_exports.dart';
import '../../../services/profile_service.dart';

part 'global_profile_state.dart';
part 'global_profile_cubit.freezed.dart';

class GlobalProfileCubit extends Cubit<GlobalProfileState> {
  final ProfileService _profileService;

  GlobalProfileCubit({required ProfileService profileService})
      : _profileService = profileService,
        super(const GlobalProfileState.initial());

  getMyProfile() async {
    emit(const GlobalProfileState.loading());

    final result = await _profileService.getMyProfile();

    result.fold(
      (failure) => emit(GlobalProfileState.error(failure)),
      (profile) => emit(GlobalProfileState.loaded(profile)),
    );
  }
}
