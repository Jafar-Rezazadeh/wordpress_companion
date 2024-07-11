// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() enterCredentials,
    required TResult Function() loggingIn,
    required TResult Function() loginSuccess,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) loginFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? enterCredentials,
    TResult? Function()? loggingIn,
    TResult? Function()? loginSuccess,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? loginFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? enterCredentials,
    TResult Function()? loggingIn,
    TResult Function()? loginSuccess,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? loginFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnterCredentials value) enterCredentials,
    required TResult Function(_LoggingIn value) loggingIn,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_LoginFailed value) loginFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EnterCredentials value)? enterCredentials,
    TResult? Function(_LoggingIn value)? loggingIn,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_LoginFailed value)? loginFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnterCredentials value)? enterCredentials,
    TResult Function(_LoggingIn value)? loggingIn,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EnterCredentialsImplCopyWith<$Res> {
  factory _$$EnterCredentialsImplCopyWith(_$EnterCredentialsImpl value,
          $Res Function(_$EnterCredentialsImpl) then) =
      __$$EnterCredentialsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EnterCredentialsImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$EnterCredentialsImpl>
    implements _$$EnterCredentialsImplCopyWith<$Res> {
  __$$EnterCredentialsImplCopyWithImpl(_$EnterCredentialsImpl _value,
      $Res Function(_$EnterCredentialsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EnterCredentialsImpl implements _EnterCredentials {
  const _$EnterCredentialsImpl();

  @override
  String toString() {
    return 'LoginState.enterCredentials()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EnterCredentialsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() enterCredentials,
    required TResult Function() loggingIn,
    required TResult Function() loginSuccess,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) loginFailed,
  }) {
    return enterCredentials();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? enterCredentials,
    TResult? Function()? loggingIn,
    TResult? Function()? loginSuccess,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? loginFailed,
  }) {
    return enterCredentials?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? enterCredentials,
    TResult Function()? loggingIn,
    TResult Function()? loginSuccess,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? loginFailed,
    required TResult orElse(),
  }) {
    if (enterCredentials != null) {
      return enterCredentials();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnterCredentials value) enterCredentials,
    required TResult Function(_LoggingIn value) loggingIn,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_LoginFailed value) loginFailed,
  }) {
    return enterCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EnterCredentials value)? enterCredentials,
    TResult? Function(_LoggingIn value)? loggingIn,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_LoginFailed value)? loginFailed,
  }) {
    return enterCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnterCredentials value)? enterCredentials,
    TResult Function(_LoggingIn value)? loggingIn,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (enterCredentials != null) {
      return enterCredentials(this);
    }
    return orElse();
  }
}

abstract class _EnterCredentials implements LoginState {
  const factory _EnterCredentials() = _$EnterCredentialsImpl;
}

/// @nodoc
abstract class _$$LoggingInImplCopyWith<$Res> {
  factory _$$LoggingInImplCopyWith(
          _$LoggingInImpl value, $Res Function(_$LoggingInImpl) then) =
      __$$LoggingInImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggingInImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoggingInImpl>
    implements _$$LoggingInImplCopyWith<$Res> {
  __$$LoggingInImplCopyWithImpl(
      _$LoggingInImpl _value, $Res Function(_$LoggingInImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoggingInImpl implements _LoggingIn {
  const _$LoggingInImpl();

  @override
  String toString() {
    return 'LoginState.loggingIn()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggingInImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() enterCredentials,
    required TResult Function() loggingIn,
    required TResult Function() loginSuccess,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) loginFailed,
  }) {
    return loggingIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? enterCredentials,
    TResult? Function()? loggingIn,
    TResult? Function()? loginSuccess,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? loginFailed,
  }) {
    return loggingIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? enterCredentials,
    TResult Function()? loggingIn,
    TResult Function()? loginSuccess,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? loginFailed,
    required TResult orElse(),
  }) {
    if (loggingIn != null) {
      return loggingIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnterCredentials value) enterCredentials,
    required TResult Function(_LoggingIn value) loggingIn,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_LoginFailed value) loginFailed,
  }) {
    return loggingIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EnterCredentials value)? enterCredentials,
    TResult? Function(_LoggingIn value)? loggingIn,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_LoginFailed value)? loginFailed,
  }) {
    return loggingIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnterCredentials value)? enterCredentials,
    TResult Function(_LoggingIn value)? loggingIn,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (loggingIn != null) {
      return loggingIn(this);
    }
    return orElse();
  }
}

abstract class _LoggingIn implements LoginState {
  const factory _LoggingIn() = _$LoggingInImpl;
}

/// @nodoc
abstract class _$$LoginSuccessImplCopyWith<$Res> {
  factory _$$LoginSuccessImplCopyWith(
          _$LoginSuccessImpl value, $Res Function(_$LoginSuccessImpl) then) =
      __$$LoginSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginSuccessImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginSuccessImpl>
    implements _$$LoginSuccessImplCopyWith<$Res> {
  __$$LoginSuccessImplCopyWithImpl(
      _$LoginSuccessImpl _value, $Res Function(_$LoginSuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginSuccessImpl implements _LoginSuccess {
  const _$LoginSuccessImpl();

  @override
  String toString() {
    return 'LoginState.loginSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() enterCredentials,
    required TResult Function() loggingIn,
    required TResult Function() loginSuccess,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) loginFailed,
  }) {
    return loginSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? enterCredentials,
    TResult? Function()? loggingIn,
    TResult? Function()? loginSuccess,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? loginFailed,
  }) {
    return loginSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? enterCredentials,
    TResult Function()? loggingIn,
    TResult Function()? loginSuccess,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginSuccess != null) {
      return loginSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnterCredentials value) enterCredentials,
    required TResult Function(_LoggingIn value) loggingIn,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_LoginFailed value) loginFailed,
  }) {
    return loginSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EnterCredentials value)? enterCredentials,
    TResult? Function(_LoggingIn value)? loggingIn,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_LoginFailed value)? loginFailed,
  }) {
    return loginSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnterCredentials value)? enterCredentials,
    TResult Function(_LoggingIn value)? loggingIn,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginSuccess != null) {
      return loginSuccess(this);
    }
    return orElse();
  }
}

abstract class _LoginSuccess implements LoginState {
  const factory _LoginSuccess() = _$LoginSuccessImpl;
}

/// @nodoc
abstract class _$$NotValidUserImplCopyWith<$Res> {
  factory _$$NotValidUserImplCopyWith(
          _$NotValidUserImpl value, $Res Function(_$NotValidUserImpl) then) =
      __$$NotValidUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotValidUserImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$NotValidUserImpl>
    implements _$$NotValidUserImplCopyWith<$Res> {
  __$$NotValidUserImplCopyWithImpl(
      _$NotValidUserImpl _value, $Res Function(_$NotValidUserImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NotValidUserImpl implements _NotValidUser {
  const _$NotValidUserImpl();

  @override
  String toString() {
    return 'LoginState.notValidUser()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotValidUserImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() enterCredentials,
    required TResult Function() loggingIn,
    required TResult Function() loginSuccess,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) loginFailed,
  }) {
    return notValidUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? enterCredentials,
    TResult? Function()? loggingIn,
    TResult? Function()? loginSuccess,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? loginFailed,
  }) {
    return notValidUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? enterCredentials,
    TResult Function()? loggingIn,
    TResult Function()? loginSuccess,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? loginFailed,
    required TResult orElse(),
  }) {
    if (notValidUser != null) {
      return notValidUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnterCredentials value) enterCredentials,
    required TResult Function(_LoggingIn value) loggingIn,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_LoginFailed value) loginFailed,
  }) {
    return notValidUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EnterCredentials value)? enterCredentials,
    TResult? Function(_LoggingIn value)? loggingIn,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_LoginFailed value)? loginFailed,
  }) {
    return notValidUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnterCredentials value)? enterCredentials,
    TResult Function(_LoggingIn value)? loggingIn,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (notValidUser != null) {
      return notValidUser(this);
    }
    return orElse();
  }
}

abstract class _NotValidUser implements LoginState {
  const factory _NotValidUser() = _$NotValidUserImpl;
}

/// @nodoc
abstract class _$$LoginFailedImplCopyWith<$Res> {
  factory _$$LoginFailedImplCopyWith(
          _$LoginFailedImpl value, $Res Function(_$LoginFailedImpl) then) =
      __$$LoginFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$LoginFailedImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginFailedImpl>
    implements _$$LoginFailedImplCopyWith<$Res> {
  __$$LoginFailedImplCopyWithImpl(
      _$LoginFailedImpl _value, $Res Function(_$LoginFailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$LoginFailedImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$LoginFailedImpl implements _LoginFailed {
  const _$LoginFailedImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'LoginState.loginFailed(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFailedImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFailedImplCopyWith<_$LoginFailedImpl> get copyWith =>
      __$$LoginFailedImplCopyWithImpl<_$LoginFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() enterCredentials,
    required TResult Function() loggingIn,
    required TResult Function() loginSuccess,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) loginFailed,
  }) {
    return loginFailed(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? enterCredentials,
    TResult? Function()? loggingIn,
    TResult? Function()? loginSuccess,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? loginFailed,
  }) {
    return loginFailed?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? enterCredentials,
    TResult Function()? loggingIn,
    TResult Function()? loginSuccess,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginFailed != null) {
      return loginFailed(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EnterCredentials value) enterCredentials,
    required TResult Function(_LoggingIn value) loggingIn,
    required TResult Function(_LoginSuccess value) loginSuccess,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_LoginFailed value) loginFailed,
  }) {
    return loginFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EnterCredentials value)? enterCredentials,
    TResult? Function(_LoggingIn value)? loggingIn,
    TResult? Function(_LoginSuccess value)? loginSuccess,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_LoginFailed value)? loginFailed,
  }) {
    return loginFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EnterCredentials value)? enterCredentials,
    TResult Function(_LoggingIn value)? loggingIn,
    TResult Function(_LoginSuccess value)? loginSuccess,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_LoginFailed value)? loginFailed,
    required TResult orElse(),
  }) {
    if (loginFailed != null) {
      return loginFailed(this);
    }
    return orElse();
  }
}

abstract class _LoginFailed implements LoginState {
  const factory _LoginFailed(final Failure failure) = _$LoginFailedImpl;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$LoginFailedImplCopyWith<_$LoginFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
