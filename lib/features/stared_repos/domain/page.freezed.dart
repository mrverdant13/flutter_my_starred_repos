// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PageTearOff {
  const _$PageTearOff();

  _Page<T> call<T>({required int lastPage, required List<T> elements}) {
    return _Page<T>(
      lastPage: lastPage,
      elements: elements,
    );
  }
}

/// @nodoc
const $Page = _$PageTearOff();

/// @nodoc
mixin _$Page<T> {
  int get lastPage => throw _privateConstructorUsedError;
  List<T> get elements => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PageCopyWith<T, Page<T>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageCopyWith<T, $Res> {
  factory $PageCopyWith(Page<T> value, $Res Function(Page<T>) then) =
      _$PageCopyWithImpl<T, $Res>;
  $Res call({int lastPage, List<T> elements});
}

/// @nodoc
class _$PageCopyWithImpl<T, $Res> implements $PageCopyWith<T, $Res> {
  _$PageCopyWithImpl(this._value, this._then);

  final Page<T> _value;
  // ignore: unused_field
  final $Res Function(Page<T>) _then;

  @override
  $Res call({
    Object? lastPage = freezed,
    Object? elements = freezed,
  }) {
    return _then(_value.copyWith(
      lastPage: lastPage == freezed
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      elements: elements == freezed
          ? _value.elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
abstract class _$PageCopyWith<T, $Res> implements $PageCopyWith<T, $Res> {
  factory _$PageCopyWith(_Page<T> value, $Res Function(_Page<T>) then) =
      __$PageCopyWithImpl<T, $Res>;
  @override
  $Res call({int lastPage, List<T> elements});
}

/// @nodoc
class __$PageCopyWithImpl<T, $Res> extends _$PageCopyWithImpl<T, $Res>
    implements _$PageCopyWith<T, $Res> {
  __$PageCopyWithImpl(_Page<T> _value, $Res Function(_Page<T>) _then)
      : super(_value, (v) => _then(v as _Page<T>));

  @override
  _Page<T> get _value => super._value as _Page<T>;

  @override
  $Res call({
    Object? lastPage = freezed,
    Object? elements = freezed,
  }) {
    return _then(_Page<T>(
      lastPage: lastPage == freezed
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int,
      elements: elements == freezed
          ? _value.elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$_Page<T> implements _Page<T> {
  const _$_Page({required this.lastPage, required this.elements});

  @override
  final int lastPage;
  @override
  final List<T> elements;

  @override
  String toString() {
    return 'Page<$T>(lastPage: $lastPage, elements: $elements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Page<T> &&
            (identical(other.lastPage, lastPage) ||
                const DeepCollectionEquality()
                    .equals(other.lastPage, lastPage)) &&
            (identical(other.elements, elements) ||
                const DeepCollectionEquality()
                    .equals(other.elements, elements)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lastPage) ^
      const DeepCollectionEquality().hash(elements);

  @JsonKey(ignore: true)
  @override
  _$PageCopyWith<T, _Page<T>> get copyWith =>
      __$PageCopyWithImpl<T, _Page<T>>(this, _$identity);
}

abstract class _Page<T> implements Page<T> {
  const factory _Page({required int lastPage, required List<T> elements}) =
      _$_Page<T>;

  @override
  int get lastPage => throw _privateConstructorUsedError;
  @override
  List<T> get elements => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PageCopyWith<T, _Page<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
