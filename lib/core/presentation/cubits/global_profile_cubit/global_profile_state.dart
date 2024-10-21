part of 'global_profile_cubit.dart';

@freezed
class GlobalProfileState with _$GlobalProfileState {
  const factory GlobalProfileState.initial() = _Initial;
  const factory GlobalProfileState.loading() = _Loading;
  const factory GlobalProfileState.loaded(ProfileEntity profile) = _Loaded;
  const factory GlobalProfileState.error(Failure failure) = _Error;
}
