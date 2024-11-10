// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_finder_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageFinderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() finding,
    required TResult Function(MediaEntity image) imageFound,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? finding,
    TResult? Function(MediaEntity image)? imageFound,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? finding,
    TResult Function(MediaEntity image)? imageFound,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Finding value) finding,
    required TResult Function(_ImageFound value) imageFound,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Finding value)? finding,
    TResult? Function(_ImageFound value)? imageFound,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Finding value)? finding,
    TResult Function(_ImageFound value)? imageFound,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageFinderStateCopyWith<$Res> {
  factory $ImageFinderStateCopyWith(
          ImageFinderState value, $Res Function(ImageFinderState) then) =
      _$ImageFinderStateCopyWithImpl<$Res, ImageFinderState>;
}

/// @nodoc
class _$ImageFinderStateCopyWithImpl<$Res, $Val extends ImageFinderState>
    implements $ImageFinderStateCopyWith<$Res> {
  _$ImageFinderStateCopyWithImpl(this._value, this._then);

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
    extends _$ImageFinderStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'ImageFinderState.initial()';
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
    required TResult Function() finding,
    required TResult Function(MediaEntity image) imageFound,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? finding,
    TResult? Function(MediaEntity image)? imageFound,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? finding,
    TResult Function(MediaEntity image)? imageFound,
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
    required TResult Function(_Finding value) finding,
    required TResult Function(_ImageFound value) imageFound,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Finding value)? finding,
    TResult? Function(_ImageFound value)? imageFound,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Finding value)? finding,
    TResult Function(_ImageFound value)? imageFound,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ImageFinderState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$FindingImplCopyWith<$Res> {
  factory _$$FindingImplCopyWith(
          _$FindingImpl value, $Res Function(_$FindingImpl) then) =
      __$$FindingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FindingImplCopyWithImpl<$Res>
    extends _$ImageFinderStateCopyWithImpl<$Res, _$FindingImpl>
    implements _$$FindingImplCopyWith<$Res> {
  __$$FindingImplCopyWithImpl(
      _$FindingImpl _value, $Res Function(_$FindingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FindingImpl implements _Finding {
  const _$FindingImpl();

  @override
  String toString() {
    return 'ImageFinderState.finding()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FindingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() finding,
    required TResult Function(MediaEntity image) imageFound,
    required TResult Function(Failure failure) error,
  }) {
    return finding();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? finding,
    TResult? Function(MediaEntity image)? imageFound,
    TResult? Function(Failure failure)? error,
  }) {
    return finding?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? finding,
    TResult Function(MediaEntity image)? imageFound,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (finding != null) {
      return finding();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Finding value) finding,
    required TResult Function(_ImageFound value) imageFound,
    required TResult Function(_Error value) error,
  }) {
    return finding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Finding value)? finding,
    TResult? Function(_ImageFound value)? imageFound,
    TResult? Function(_Error value)? error,
  }) {
    return finding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Finding value)? finding,
    TResult Function(_ImageFound value)? imageFound,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (finding != null) {
      return finding(this);
    }
    return orElse();
  }
}

abstract class _Finding implements ImageFinderState {
  const factory _Finding() = _$FindingImpl;
}

/// @nodoc
abstract class _$$ImageFoundImplCopyWith<$Res> {
  factory _$$ImageFoundImplCopyWith(
          _$ImageFoundImpl value, $Res Function(_$ImageFoundImpl) then) =
      __$$ImageFoundImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MediaEntity image});
}

/// @nodoc
class __$$ImageFoundImplCopyWithImpl<$Res>
    extends _$ImageFinderStateCopyWithImpl<$Res, _$ImageFoundImpl>
    implements _$$ImageFoundImplCopyWith<$Res> {
  __$$ImageFoundImplCopyWithImpl(
      _$ImageFoundImpl _value, $Res Function(_$ImageFoundImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
  }) {
    return _then(_$ImageFoundImpl(
      null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as MediaEntity,
    ));
  }
}

/// @nodoc

class _$ImageFoundImpl implements _ImageFound {
  const _$ImageFoundImpl(this.image);

  @override
  final MediaEntity image;

  @override
  String toString() {
    return 'ImageFinderState.imageFound(image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageFoundImpl &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageFoundImplCopyWith<_$ImageFoundImpl> get copyWith =>
      __$$ImageFoundImplCopyWithImpl<_$ImageFoundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() finding,
    required TResult Function(MediaEntity image) imageFound,
    required TResult Function(Failure failure) error,
  }) {
    return imageFound(image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? finding,
    TResult? Function(MediaEntity image)? imageFound,
    TResult? Function(Failure failure)? error,
  }) {
    return imageFound?.call(image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? finding,
    TResult Function(MediaEntity image)? imageFound,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (imageFound != null) {
      return imageFound(image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Finding value) finding,
    required TResult Function(_ImageFound value) imageFound,
    required TResult Function(_Error value) error,
  }) {
    return imageFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Finding value)? finding,
    TResult? Function(_ImageFound value)? imageFound,
    TResult? Function(_Error value)? error,
  }) {
    return imageFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Finding value)? finding,
    TResult Function(_ImageFound value)? imageFound,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (imageFound != null) {
      return imageFound(this);
    }
    return orElse();
  }
}

abstract class _ImageFound implements ImageFinderState {
  const factory _ImageFound(final MediaEntity image) = _$ImageFoundImpl;

  MediaEntity get image;
  @JsonKey(ignore: true)
  _$$ImageFoundImplCopyWith<_$ImageFoundImpl> get copyWith =>
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
    extends _$ImageFinderStateCopyWithImpl<$Res, _$ErrorImpl>
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
    return 'ImageFinderState.error(failure: $failure)';
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
    required TResult Function() finding,
    required TResult Function(MediaEntity image) imageFound,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? finding,
    TResult? Function(MediaEntity image)? imageFound,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? finding,
    TResult Function(MediaEntity image)? imageFound,
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
    required TResult Function(_Finding value) finding,
    required TResult Function(_ImageFound value) imageFound,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Finding value)? finding,
    TResult? Function(_ImageFound value)? imageFound,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Finding value)? finding,
    TResult Function(_ImageFound value)? imageFound,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ImageFinderState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
