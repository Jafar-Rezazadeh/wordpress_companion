import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

part 'login_credentials_state.dart';
part 'login_credentials_cubit.freezed.dart';

class LoginCredentialsCubit extends Cubit<LoginCredentialsState> {
  final GetLastLoginCredentials _getLastLoginCredentials;

  LoginCredentialsCubit({
    required GetLastLoginCredentials getLastLoginCredentials,
  })  : _getLastLoginCredentials = getLastLoginCredentials,
        super(const LoginCredentialsState.initial());

  getLastLoginCredentials() async {
    emit(const LoginCredentialsState.gettingCredentials());

    final result = await _getLastLoginCredentials(NoParams());

    result.fold(
      (failure) => emit(LoginCredentialsState.error(failure)),
      (credentials) => emit(
        LoginCredentialsState.credentialsReceived(credentials),
      ),
    );
  }
}
