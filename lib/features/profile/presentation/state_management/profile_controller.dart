import 'package:get/get.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../../../../core/core_export.dart';

class ProfileController extends GetxController with StateMixin<ProfileEntity> {
  final GetMyProfile _getMyProfile;
  final UpdateMyProfile _updateMyProfile;
  final statusHistory = <RxStatus>[];
  final _failure = Rx<Failure?>(null);
  final _currentStatus = Rx<RxStatus>(RxStatus.empty());
  final _profileData = Rx<ProfileEntity?>(null);

  ProfileController({
    required GetMyProfile getMyProfile,
    required UpdateMyProfile updateMyProfile,
  })  : _getMyProfile = getMyProfile,
        _updateMyProfile = updateMyProfile;

  Failure? get failure => _failure.value;
  RxStatus get currentStatus => _currentStatus.value;
  ProfileEntity? get profileData => _profileData.value;

  @override
  void onInit() {
    super.onInit();
    getMyProfile();
  }

  @override
  void change(ProfileEntity? newState, {RxStatus? status}) {
    _setVariables(status, newState);
    super.change(newState, status: status);
  }

  void _setVariables(RxStatus? status, ProfileEntity? newState) {
    if (status != null) {
      _setCurrentStatus(status);
      _addStatusToHistory(status);
      _clearFailureWhenStatusIsNotError(status);
    }

    _profileData.value = newState;
  }

  void _setCurrentStatus(RxStatus status) {
    _currentStatus.value = status;
  }

  void _addStatusToHistory(RxStatus status) {
    statusHistory.add(status);
  }

  void _clearFailureWhenStatusIsNotError(RxStatus status) {
    if (status.isError == false) {
      _failure.value = null;
    }
  }

  @override
  void dispose() {
    statusHistory.clear();

    super.dispose();
  }

  Future<void> getMyProfile() async {
    statusHistory.clear();

    change(null, status: RxStatus.loading());

    final result = await _getMyProfile(NoParams());

    result.fold(
      (failure) {
        _failure.value = failure;

        change(null, status: RxStatus.error(failure.message));
      },
      (profile) => change(profile, status: RxStatus.success()),
    );
  }

  Future<void> updateMyProfile(UpdateMyProfileParams params) async {
    statusHistory.clear();

    change(null, status: RxStatus.loading());

    final result = await _updateMyProfile.call(params);

    result.fold(
      (failure) {
        _failure.value = failure;
        change(null, status: RxStatus.error());
      },
      (updatedProfile) => change(updatedProfile, status: RxStatus.success()),
    );
  }
}
