// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PayloadTearOff {
  const _$PayloadTearOff();

  PayloadWithoutWarning<D, W> call<D, W>(D data) {
    return PayloadWithoutWarning<D, W>(
      data,
    );
  }

  PayloadWithWarning<D, W> withWarning<D, W>(
      {required D data, required W warning}) {
    return PayloadWithWarning<D, W>(
      data: data,
      warning: warning,
    );
  }
}

/// @nodoc
const $Payload = _$PayloadTearOff();

/// @nodoc
mixin _$Payload<D, W> {
  D get data => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(D data) $default, {
    required TResult Function(D data, W warning) withWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value) $default, {
    required TResult Function(PayloadWithWarning<D, W> value) withWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value)? $default, {
    TResult Function(PayloadWithWarning<D, W> value)? withWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value)? $default, {
    TResult Function(PayloadWithWarning<D, W> value)? withWarning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PayloadCopyWith<D, W, Payload<D, W>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadCopyWith<D, W, $Res> {
  factory $PayloadCopyWith(
          Payload<D, W> value, $Res Function(Payload<D, W>) then) =
      _$PayloadCopyWithImpl<D, W, $Res>;
  $Res call({D data});
}

/// @nodoc
class _$PayloadCopyWithImpl<D, W, $Res>
    implements $PayloadCopyWith<D, W, $Res> {
  _$PayloadCopyWithImpl(this._value, this._then);

  final Payload<D, W> _value;
  // ignore: unused_field
  final $Res Function(Payload<D, W>) _then;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as D,
    ));
  }
}

/// @nodoc
abstract class $PayloadWithoutWarningCopyWith<D, W, $Res>
    implements $PayloadCopyWith<D, W, $Res> {
  factory $PayloadWithoutWarningCopyWith(PayloadWithoutWarning<D, W> value,
          $Res Function(PayloadWithoutWarning<D, W>) then) =
      _$PayloadWithoutWarningCopyWithImpl<D, W, $Res>;
  @override
  $Res call({D data});
}

/// @nodoc
class _$PayloadWithoutWarningCopyWithImpl<D, W, $Res>
    extends _$PayloadCopyWithImpl<D, W, $Res>
    implements $PayloadWithoutWarningCopyWith<D, W, $Res> {
  _$PayloadWithoutWarningCopyWithImpl(PayloadWithoutWarning<D, W> _value,
      $Res Function(PayloadWithoutWarning<D, W>) _then)
      : super(_value, (v) => _then(v as PayloadWithoutWarning<D, W>));

  @override
  PayloadWithoutWarning<D, W> get _value =>
      super._value as PayloadWithoutWarning<D, W>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(PayloadWithoutWarning<D, W>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as D,
    ));
  }
}

/// @nodoc

class _$PayloadWithoutWarning<D, W> implements PayloadWithoutWarning<D, W> {
  const _$PayloadWithoutWarning(this.data);

  @override
  final D data;

  @override
  String toString() {
    return 'Payload<$D, $W>(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PayloadWithoutWarning<D, W> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  $PayloadWithoutWarningCopyWith<D, W, PayloadWithoutWarning<D, W>>
      get copyWith => _$PayloadWithoutWarningCopyWithImpl<D, W,
          PayloadWithoutWarning<D, W>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(D data) $default, {
    required TResult Function(D data, W warning) withWarning,
  }) {
    return $default(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
  }) {
    return $default?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value) $default, {
    required TResult Function(PayloadWithWarning<D, W> value) withWarning,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value)? $default, {
    TResult Function(PayloadWithWarning<D, W> value)? withWarning,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value)? $default, {
    TResult Function(PayloadWithWarning<D, W> value)? withWarning,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class PayloadWithoutWarning<D, W> implements Payload<D, W> {
  const factory PayloadWithoutWarning(D data) = _$PayloadWithoutWarning<D, W>;

  @override
  D get data;
  @override
  @JsonKey(ignore: true)
  $PayloadWithoutWarningCopyWith<D, W, PayloadWithoutWarning<D, W>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadWithWarningCopyWith<D, W, $Res>
    implements $PayloadCopyWith<D, W, $Res> {
  factory $PayloadWithWarningCopyWith(PayloadWithWarning<D, W> value,
          $Res Function(PayloadWithWarning<D, W>) then) =
      _$PayloadWithWarningCopyWithImpl<D, W, $Res>;
  @override
  $Res call({D data, W warning});
}

/// @nodoc
class _$PayloadWithWarningCopyWithImpl<D, W, $Res>
    extends _$PayloadCopyWithImpl<D, W, $Res>
    implements $PayloadWithWarningCopyWith<D, W, $Res> {
  _$PayloadWithWarningCopyWithImpl(PayloadWithWarning<D, W> _value,
      $Res Function(PayloadWithWarning<D, W>) _then)
      : super(_value, (v) => _then(v as PayloadWithWarning<D, W>));

  @override
  PayloadWithWarning<D, W> get _value =>
      super._value as PayloadWithWarning<D, W>;

  @override
  $Res call({
    Object? data = freezed,
    Object? warning = freezed,
  }) {
    return _then(PayloadWithWarning<D, W>(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as D,
      warning: warning == freezed
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as W,
    ));
  }
}

/// @nodoc

class _$PayloadWithWarning<D, W> implements PayloadWithWarning<D, W> {
  const _$PayloadWithWarning({required this.data, required this.warning});

  @override
  final D data;
  @override
  final W warning;

  @override
  String toString() {
    return 'Payload<$D, $W>.withWarning(data: $data, warning: $warning)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PayloadWithWarning<D, W> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.warning, warning));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(warning));

  @JsonKey(ignore: true)
  @override
  $PayloadWithWarningCopyWith<D, W, PayloadWithWarning<D, W>> get copyWith =>
      _$PayloadWithWarningCopyWithImpl<D, W, PayloadWithWarning<D, W>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(D data) $default, {
    required TResult Function(D data, W warning) withWarning,
  }) {
    return withWarning(data, warning);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
  }) {
    return withWarning?.call(data, warning);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(D data)? $default, {
    TResult Function(D data, W warning)? withWarning,
    required TResult orElse(),
  }) {
    if (withWarning != null) {
      return withWarning(data, warning);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value) $default, {
    required TResult Function(PayloadWithWarning<D, W> value) withWarning,
  }) {
    return withWarning(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value)? $default, {
    TResult Function(PayloadWithWarning<D, W> value)? withWarning,
  }) {
    return withWarning?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(PayloadWithoutWarning<D, W> value)? $default, {
    TResult Function(PayloadWithWarning<D, W> value)? withWarning,
    required TResult orElse(),
  }) {
    if (withWarning != null) {
      return withWarning(this);
    }
    return orElse();
  }
}

abstract class PayloadWithWarning<D, W> implements Payload<D, W> {
  const factory PayloadWithWarning({required D data, required W warning}) =
      _$PayloadWithWarning<D, W>;

  @override
  D get data;
  W get warning;
  @override
  @JsonKey(ignore: true)
  $PayloadWithWarningCopyWith<D, W, PayloadWithWarning<D, W>> get copyWith =>
      throw _privateConstructorUsedError;
}
