// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_credentials_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginCredentialsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() gettingCredentials,
    required TResult Function(LoginCredentialsEntity credentials)
        credentialsReceived,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? gettingCredentials,
    TResult? Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? gettingCredentials,
    TResult Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GettingCredentials value) gettingCredentials,
    required TResult Function(_CredentialsReceived value) credentialsReceived,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GettingCredentials value)? gettingCredentials,
    TResult? Function(_CredentialsReceived value)? credentialsReceived,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GettingCredentials value)? gettingCredentials,
    TResult Function(_CredentialsReceived value)? credentialsReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginCredentialsStateCopyWith<$Res> {
  factory $LoginCredentialsStateCopyWith(LoginCredentialsState value,
          $Res Function(LoginCredentialsState) then) =
      _$LoginCredentialsStateCopyWithImpl<$Res, LoginCredentialsState>;
}

/// @nodoc
class _$LoginCredentialsStateCopyWithImpl<$Res,
        $Val extends LoginCredentialsState>
    implements $LoginCredentialsStateCopyWith<$Res> {
  _$LoginCredentialsStateCopyWithImpl(this._value, this._then);

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
    extends _$LoginCredentialsStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'LoginCredentialsState.initial()';
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
    required TResult Function() gettingCredentials,
    required TResult Function(LoginCredentialsEntity credentials)
        credentialsReceived,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? gettingCredentials,
    TResult? Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? gettingCredentials,
    TResult Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult Function(Failure failure)? error,
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
    required TResult Function(_GettingCredentials value) gettingCredentials,
    required TResult Function(_CredentialsReceived value) credentialsReceived,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GettingCredentials value)? gettingCredentials,
    TResult? Function(_CredentialsReceived value)? credentialsReceived,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GettingCredentials value)? gettingCredentials,
    TResult Function(_CredentialsReceived value)? credentialsReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LoginCredentialsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$GettingCredentialsImplCopyWith<$Res> {
  factory _$$GettingCredentialsImplCopyWith(_$GettingCredentialsImpl value,
          $Res Function(_$GettingCredentialsImpl) then) =
      __$$GettingCredentialsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GettingCredentialsImplCopyWithImpl<$Res>
    extends _$LoginCredentialsStateCopyWithImpl<$Res, _$GettingCredentialsImpl>
    implements _$$GettingCredentialsImplCopyWith<$Res> {
  __$$GettingCredentialsImplCopyWithImpl(_$GettingCredentialsImpl _value,
      $Res Function(_$GettingCredentialsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GettingCredentialsImpl implements _GettingCredentials {
  const _$GettingCredentialsImpl();

  @override
  String toString() {
    return 'LoginCredentialsState.gettingCredentials()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GettingCredentialsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() gettingCredentials,
    required TResult Function(LoginCredentialsEntity credentials)
        credentialsReceived,
    required TResult Function(Failure failure) error,
  }) {
    return gettingCredentials();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? gettingCredentials,
    TResult? Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult? Function(Failure failure)? error,
  }) {
    return gettingCredentials?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? gettingCredentials,
    TResult Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (gettingCredentials != null) {
      return gettingCredentials();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GettingCredentials value) gettingCredentials,
    required TResult Function(_CredentialsReceived value) credentialsReceived,
    required TResult Function(_Error value) error,
  }) {
    return gettingCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GettingCredentials value)? gettingCredentials,
    TResult? Function(_CredentialsReceived value)? credentialsReceived,
    TResult? Function(_Error value)? error,
  }) {
    return gettingCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GettingCredentials value)? gettingCredentials,
    TResult Function(_CredentialsReceived value)? credentialsReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (gettingCredentials != null) {
      return gettingCredentials(this);
    }
    return orElse();
  }
}

abstract class _GettingCredentials implements LoginCredentialsState {
  const factory _GettingCredentials() = _$GettingCredentialsImpl;
}

/// @nodoc
abstract class _$$CredentialsReceivedImplCopyWith<$Res> {
  factory _$$CredentialsReceivedImplCopyWith(_$CredentialsReceivedImpl value,
          $Res Function(_$CredentialsReceivedImpl) then) =
      __$$CredentialsReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginCredentialsEntity credentials});
}

/// @nodoc
class __$$CredentialsReceivedImplCopyWithImpl<$Res>
    extends _$LoginCredentialsStateCopyWithImpl<$Res, _$CredentialsReceivedImpl>
    implements _$$CredentialsReceivedImplCopyWith<$Res> {
  __$$CredentialsReceivedImplCopyWithImpl(_$CredentialsReceivedImpl _value,
      $Res Function(_$CredentialsReceivedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credentials = null,
  }) {
    return _then(_$CredentialsReceivedImpl(
      null == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as LoginCredentialsEntity,
    ));
  }
}

/// @nodoc

class _$CredentialsReceivedImpl implements _CredentialsReceived {
  const _$CredentialsReceivedImpl(this.credentials);

  @override
  final LoginCredentialsEntity credentials;

  @override
  String toString() {
    return 'LoginCredentialsState.credentialsReceived(credentials: $credentials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialsReceivedImpl &&
            (identical(other.credentials, credentials) ||
                other.credentials == credentials));
  }

  @override
  int get hashCode => Object.hash(runtimeType, credentials);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialsReceivedImplCopyWith<_$CredentialsReceivedImpl> get copyWith =>
      __$$CredentialsReceivedImplCopyWithImpl<_$CredentialsReceivedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() gettingCredentials,
    required TResult Function(LoginCredentialsEntity credentials)
        credentialsReceived,
    required TResult Function(Failure failure) error,
  }) {
    return credentialsReceived(credentials);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? gettingCredentials,
    TResult? Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult? Function(Failure failure)? error,
  }) {
    return credentialsReceived?.call(credentials);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? gettingCredentials,
    TResult Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (credentialsReceived != null) {
      return credentialsReceived(credentials);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GettingCredentials value) gettingCredentials,
    required TResult Function(_CredentialsReceived value) credentialsReceived,
    required TResult Function(_Error value) error,
  }) {
    return credentialsReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GettingCredentials value)? gettingCredentials,
    TResult? Function(_CredentialsReceived value)? credentialsReceived,
    TResult? Function(_Error value)? error,
  }) {
    return credentialsReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GettingCredentials value)? gettingCredentials,
    TResult Function(_CredentialsReceived value)? credentialsReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (credentialsReceived != null) {
      return credentialsReceived(this);
    }
    return orElse();
  }
}

abstract class _CredentialsReceived implements LoginCredentialsState {
  const factory _CredentialsReceived(final LoginCredentialsEntity credentials) =
      _$CredentialsReceivedImpl;

  LoginCredentialsEntity get credentials;
  @JsonKey(ignore: true)
  _$$CredentialsReceivedImplCopyWith<_$CredentialsReceivedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$LoginCredentialsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ErrorImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'LoginCredentialsState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() gettingCredentials,
    required TResult Function(LoginCredentialsEntity credentials)
        credentialsReceived,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? gettingCredentials,
    TResult? Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? gettingCredentials,
    TResult Function(LoginCredentialsEntity credentials)? credentialsReceived,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_GettingCredentials value) gettingCredentials,
    required TResult Function(_CredentialsReceived value) credentialsReceived,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_GettingCredentials value)? gettingCredentials,
    TResult? Function(_CredentialsReceived value)? credentialsReceived,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_GettingCredentials value)? gettingCredentials,
    TResult Function(_CredentialsReceived value)? credentialsReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements LoginCredentialsState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
