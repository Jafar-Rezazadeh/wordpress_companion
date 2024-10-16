// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() authenticating,
    required TResult Function(LoginCredentialsEntity credentials) authenticated,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) authenticationFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? authenticating,
    TResult? Function(LoginCredentialsEntity credentials)? authenticated,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? authenticationFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? authenticating,
    TResult Function(LoginCredentialsEntity credentials)? authenticated,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? authenticationFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AuthenticationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() authenticating,
    required TResult Function(LoginCredentialsEntity credentials) authenticated,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) authenticationFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? authenticating,
    TResult? Function(LoginCredentialsEntity credentials)? authenticated,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? authenticationFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? authenticating,
    TResult Function(LoginCredentialsEntity credentials)? authenticated,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthenticationState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$AuthenticatingImplCopyWith<$Res> {
  factory _$$AuthenticatingImplCopyWith(_$AuthenticatingImpl value,
          $Res Function(_$AuthenticatingImpl) then) =
      __$$AuthenticatingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticatingImpl>
    implements _$$AuthenticatingImplCopyWith<$Res> {
  __$$AuthenticatingImplCopyWithImpl(
      _$AuthenticatingImpl _value, $Res Function(_$AuthenticatingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticatingImpl implements _Authenticating {
  const _$AuthenticatingImpl();

  @override
  String toString() {
    return 'AuthenticationState.authenticating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticatingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() authenticating,
    required TResult Function(LoginCredentialsEntity credentials) authenticated,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) authenticationFailed,
  }) {
    return authenticating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? authenticating,
    TResult? Function(LoginCredentialsEntity credentials)? authenticated,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? authenticationFailed,
  }) {
    return authenticating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? authenticating,
    TResult Function(LoginCredentialsEntity credentials)? authenticated,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return authenticating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return authenticating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating(this);
    }
    return orElse();
  }
}

abstract class _Authenticating implements AuthenticationState {
  const factory _Authenticating() = _$AuthenticatingImpl;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginCredentialsEntity credentials});
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentials = null,
  }) {
    return _then(_$AuthenticatedImpl(
      null == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as LoginCredentialsEntity,
    ));
  }
}

/// @nodoc

class _$AuthenticatedImpl implements _Authenticated {
  _$AuthenticatedImpl(this.credentials);

  @override
  final LoginCredentialsEntity credentials;

  @override
  String toString() {
    return 'AuthenticationState.authenticated(credentials: $credentials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.credentials, credentials) ||
                other.credentials == credentials));
  }

  @override
  int get hashCode => Object.hash(runtimeType, credentials);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() authenticating,
    required TResult Function(LoginCredentialsEntity credentials) authenticated,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) authenticationFailed,
  }) {
    return authenticated(credentials);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? authenticating,
    TResult? Function(LoginCredentialsEntity credentials)? authenticated,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? authenticationFailed,
  }) {
    return authenticated?.call(credentials);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? authenticating,
    TResult Function(LoginCredentialsEntity credentials)? authenticated,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(credentials);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthenticationState {
  factory _Authenticated(final LoginCredentialsEntity credentials) =
      _$AuthenticatedImpl;

  LoginCredentialsEntity get credentials;
  @JsonKey(ignore: true)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotValidUserImplCopyWith<$Res> {
  factory _$$NotValidUserImplCopyWith(
          _$NotValidUserImpl value, $Res Function(_$NotValidUserImpl) then) =
      __$$NotValidUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotValidUserImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$NotValidUserImpl>
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
    return 'AuthenticationState.notValidUser()';
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
    required TResult Function() initial,
    required TResult Function() authenticating,
    required TResult Function(LoginCredentialsEntity credentials) authenticated,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) authenticationFailed,
  }) {
    return notValidUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? authenticating,
    TResult? Function(LoginCredentialsEntity credentials)? authenticated,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? authenticationFailed,
  }) {
    return notValidUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? authenticating,
    TResult Function(LoginCredentialsEntity credentials)? authenticated,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? authenticationFailed,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return notValidUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return notValidUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (notValidUser != null) {
      return notValidUser(this);
    }
    return orElse();
  }
}

abstract class _NotValidUser implements AuthenticationState {
  const factory _NotValidUser() = _$NotValidUserImpl;
}

/// @nodoc
abstract class _$$AuthenticationFailedImplCopyWith<$Res> {
  factory _$$AuthenticationFailedImplCopyWith(_$AuthenticationFailedImpl value,
          $Res Function(_$AuthenticationFailedImpl) then) =
      __$$AuthenticationFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$AuthenticationFailedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationFailedImpl>
    implements _$$AuthenticationFailedImplCopyWith<$Res> {
  __$$AuthenticationFailedImplCopyWithImpl(_$AuthenticationFailedImpl _value,
      $Res Function(_$AuthenticationFailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$AuthenticationFailedImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$AuthenticationFailedImpl implements _AuthenticationFailed {
  const _$AuthenticationFailedImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'AuthenticationState.authenticationFailed(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailedImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationFailedImplCopyWith<_$AuthenticationFailedImpl>
      get copyWith =>
          __$$AuthenticationFailedImplCopyWithImpl<_$AuthenticationFailedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() authenticating,
    required TResult Function(LoginCredentialsEntity credentials) authenticated,
    required TResult Function() notValidUser,
    required TResult Function(Failure failure) authenticationFailed,
  }) {
    return authenticationFailed(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? authenticating,
    TResult? Function(LoginCredentialsEntity credentials)? authenticated,
    TResult? Function()? notValidUser,
    TResult? Function(Failure failure)? authenticationFailed,
  }) {
    return authenticationFailed?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? authenticating,
    TResult Function(LoginCredentialsEntity credentials)? authenticated,
    TResult Function()? notValidUser,
    TResult Function(Failure failure)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticationFailed != null) {
      return authenticationFailed(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_NotValidUser value) notValidUser,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return authenticationFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_NotValidUser value)? notValidUser,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return authenticationFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_NotValidUser value)? notValidUser,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticationFailed != null) {
      return authenticationFailed(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationFailed implements AuthenticationState {
  const factory _AuthenticationFailed(final Failure failure) =
      _$AuthenticationFailedImpl;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$AuthenticationFailedImplCopyWith<_$AuthenticationFailedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
