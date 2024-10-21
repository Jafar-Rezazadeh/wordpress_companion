import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

part 'site_settings_state.dart';
part 'site_settings_cubit.freezed.dart';

class SiteSettingsCubit extends Cubit<SiteSettingsState> {
  final GetSiteSettings _getSiteSettings;
  final UpdateSiteSettings _updateSiteSettings;

  SiteSettingsCubit({
    required GetSiteSettings getSiteSettings,
    required UpdateSiteSettings updateSiteSettings,
  })  : _getSiteSettings = getSiteSettings,
        _updateSiteSettings = updateSiteSettings,
        super(const SiteSettingsState.initial());

  loadSettings() async {
    emit(const SiteSettingsState.loading());

    final result = await _getSiteSettings(NoParams());

    result.fold(
      (failure) => emit(SiteSettingsState.error(failure)),
      (settings) => emit(SiteSettingsState.loaded(settings)),
    );
  }

  updateSettings(UpdateSiteSettingsParams params) async {
    emit(const SiteSettingsState.updating());

    final result = await _updateSiteSettings(params);

    result.fold(
      (failure) => emit(SiteSettingsState.error(failure)),
      (settings) => emit(SiteSettingsState.updated(settings)),
    );
  }
}
