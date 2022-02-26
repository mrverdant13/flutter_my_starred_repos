// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'starred_repos.notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StarredReposStateTearOff {
  const _$StarredReposStateTearOff();

  _StarredReposStateLoading loading(
      {required int currentPage, required List<GithubRepo> repos}) {
    return _StarredReposStateLoading(
      currentPage: currentPage,
      repos: repos,
    );
  }

  _StarredReposStateLoaded loaded(
      {required int currentPage,
      required List<GithubRepo> repos,
      required bool canLoadMore,
      GetStaredReposWarning? warning}) {
    return _StarredReposStateLoaded(
      currentPage: currentPage,
      repos: repos,
      canLoadMore: canLoadMore,
      warning: warning,
    );
  }
}

/// @nodoc
const $StarredReposState = _$StarredReposStateTearOff();

/// @nodoc
mixin _$StarredReposState {
  int get currentPage => throw _privateConstructorUsedError;
  List<GithubRepo> get repos => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int currentPage, List<GithubRepo> repos) loading,
    required TResult Function(int currentPage, List<GithubRepo> repos,
            bool canLoadMore, GetStaredReposWarning? warning)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int currentPage, List<GithubRepo> repos)? loading,
    TResult Function(int currentPage, List<GithubRepo> repos, bool canLoadMore,
            GetStaredReposWarning? warning)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int currentPage, List<GithubRepo> repos)? loading,
    TResult Function(int currentPage, List<GithubRepo> repos, bool canLoadMore,
            GetStaredReposWarning? warning)?
        loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StarredReposStateLoading value) loading,
    required TResult Function(_StarredReposStateLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StarredReposStateCopyWith<StarredReposState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StarredReposStateCopyWith<$Res> {
  factory $StarredReposStateCopyWith(
          StarredReposState value, $Res Function(StarredReposState) then) =
      _$StarredReposStateCopyWithImpl<$Res>;
  $Res call({int currentPage, List<GithubRepo> repos});
}

/// @nodoc
class _$StarredReposStateCopyWithImpl<$Res>
    implements $StarredReposStateCopyWith<$Res> {
  _$StarredReposStateCopyWithImpl(this._value, this._then);

  final StarredReposState _value;
  // ignore: unused_field
  final $Res Function(StarredReposState) _then;

  @override
  $Res call({
    Object? currentPage = freezed,
    Object? repos = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      repos: repos == freezed
          ? _value.repos
          : repos // ignore: cast_nullable_to_non_nullable
              as List<GithubRepo>,
    ));
  }
}

/// @nodoc
abstract class _$StarredReposStateLoadingCopyWith<$Res>
    implements $StarredReposStateCopyWith<$Res> {
  factory _$StarredReposStateLoadingCopyWith(_StarredReposStateLoading value,
          $Res Function(_StarredReposStateLoading) then) =
      __$StarredReposStateLoadingCopyWithImpl<$Res>;
  @override
  $Res call({int currentPage, List<GithubRepo> repos});
}

/// @nodoc
class __$StarredReposStateLoadingCopyWithImpl<$Res>
    extends _$StarredReposStateCopyWithImpl<$Res>
    implements _$StarredReposStateLoadingCopyWith<$Res> {
  __$StarredReposStateLoadingCopyWithImpl(_StarredReposStateLoading _value,
      $Res Function(_StarredReposStateLoading) _then)
      : super(_value, (v) => _then(v as _StarredReposStateLoading));

  @override
  _StarredReposStateLoading get _value =>
      super._value as _StarredReposStateLoading;

  @override
  $Res call({
    Object? currentPage = freezed,
    Object? repos = freezed,
  }) {
    return _then(_StarredReposStateLoading(
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      repos: repos == freezed
          ? _value.repos
          : repos // ignore: cast_nullable_to_non_nullable
              as List<GithubRepo>,
    ));
  }
}

/// @nodoc

class _$_StarredReposStateLoading implements _StarredReposStateLoading {
  const _$_StarredReposStateLoading(
      {required this.currentPage, required this.repos});

  @override
  final int currentPage;
  @override
  final List<GithubRepo> repos;

  @override
  String toString() {
    return 'StarredReposState.loading(currentPage: $currentPage, repos: $repos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StarredReposStateLoading &&
            const DeepCollectionEquality()
                .equals(other.currentPage, currentPage) &&
            const DeepCollectionEquality().equals(other.repos, repos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(currentPage),
      const DeepCollectionEquality().hash(repos));

  @JsonKey(ignore: true)
  @override
  _$StarredReposStateLoadingCopyWith<_StarredReposStateLoading> get copyWith =>
      __$StarredReposStateLoadingCopyWithImpl<_StarredReposStateLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int currentPage, List<GithubRepo> repos) loading,
    required TResult Function(int currentPage, List<GithubRepo> repos,
            bool canLoadMore, GetStaredReposWarning? warning)
        loaded,
  }) {
    return loading(currentPage, repos);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int currentPage, List<GithubRepo> repos)? loading,
    TResult Function(int currentPage, List<GithubRepo> repos, bool canLoadMore,
            GetStaredReposWarning? warning)?
        loaded,
  }) {
    return loading?.call(currentPage, repos);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int currentPage, List<GithubRepo> repos)? loading,
    TResult Function(int currentPage, List<GithubRepo> repos, bool canLoadMore,
            GetStaredReposWarning? warning)?
        loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(currentPage, repos);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StarredReposStateLoading value) loading,
    required TResult Function(_StarredReposStateLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _StarredReposStateLoading implements StarredReposState {
  const factory _StarredReposStateLoading(
      {required int currentPage,
      required List<GithubRepo> repos}) = _$_StarredReposStateLoading;

  @override
  int get currentPage;
  @override
  List<GithubRepo> get repos;
  @override
  @JsonKey(ignore: true)
  _$StarredReposStateLoadingCopyWith<_StarredReposStateLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$StarredReposStateLoadedCopyWith<$Res>
    implements $StarredReposStateCopyWith<$Res> {
  factory _$StarredReposStateLoadedCopyWith(_StarredReposStateLoaded value,
          $Res Function(_StarredReposStateLoaded) then) =
      __$StarredReposStateLoadedCopyWithImpl<$Res>;
  @override
  $Res call(
      {int currentPage,
      List<GithubRepo> repos,
      bool canLoadMore,
      GetStaredReposWarning? warning});

  $GetStaredReposWarningCopyWith<$Res>? get warning;
}

/// @nodoc
class __$StarredReposStateLoadedCopyWithImpl<$Res>
    extends _$StarredReposStateCopyWithImpl<$Res>
    implements _$StarredReposStateLoadedCopyWith<$Res> {
  __$StarredReposStateLoadedCopyWithImpl(_StarredReposStateLoaded _value,
      $Res Function(_StarredReposStateLoaded) _then)
      : super(_value, (v) => _then(v as _StarredReposStateLoaded));

  @override
  _StarredReposStateLoaded get _value =>
      super._value as _StarredReposStateLoaded;

  @override
  $Res call({
    Object? currentPage = freezed,
    Object? repos = freezed,
    Object? canLoadMore = freezed,
    Object? warning = freezed,
  }) {
    return _then(_StarredReposStateLoaded(
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      repos: repos == freezed
          ? _value.repos
          : repos // ignore: cast_nullable_to_non_nullable
              as List<GithubRepo>,
      canLoadMore: canLoadMore == freezed
          ? _value.canLoadMore
          : canLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      warning: warning == freezed
          ? _value.warning
          : warning // ignore: cast_nullable_to_non_nullable
              as GetStaredReposWarning?,
    ));
  }

  @override
  $GetStaredReposWarningCopyWith<$Res>? get warning {
    if (_value.warning == null) {
      return null;
    }

    return $GetStaredReposWarningCopyWith<$Res>(_value.warning!, (value) {
      return _then(_value.copyWith(warning: value));
    });
  }
}

/// @nodoc

class _$_StarredReposStateLoaded implements _StarredReposStateLoaded {
  const _$_StarredReposStateLoaded(
      {required this.currentPage,
      required this.repos,
      required this.canLoadMore,
      this.warning});

  @override
  final int currentPage;
  @override
  final List<GithubRepo> repos;
  @override
  final bool canLoadMore;
  @override
  final GetStaredReposWarning? warning;

  @override
  String toString() {
    return 'StarredReposState.loaded(currentPage: $currentPage, repos: $repos, canLoadMore: $canLoadMore, warning: $warning)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StarredReposStateLoaded &&
            const DeepCollectionEquality()
                .equals(other.currentPage, currentPage) &&
            const DeepCollectionEquality().equals(other.repos, repos) &&
            const DeepCollectionEquality()
                .equals(other.canLoadMore, canLoadMore) &&
            const DeepCollectionEquality().equals(other.warning, warning));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(currentPage),
      const DeepCollectionEquality().hash(repos),
      const DeepCollectionEquality().hash(canLoadMore),
      const DeepCollectionEquality().hash(warning));

  @JsonKey(ignore: true)
  @override
  _$StarredReposStateLoadedCopyWith<_StarredReposStateLoaded> get copyWith =>
      __$StarredReposStateLoadedCopyWithImpl<_StarredReposStateLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int currentPage, List<GithubRepo> repos) loading,
    required TResult Function(int currentPage, List<GithubRepo> repos,
            bool canLoadMore, GetStaredReposWarning? warning)
        loaded,
  }) {
    return loaded(currentPage, repos, canLoadMore, warning);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int currentPage, List<GithubRepo> repos)? loading,
    TResult Function(int currentPage, List<GithubRepo> repos, bool canLoadMore,
            GetStaredReposWarning? warning)?
        loaded,
  }) {
    return loaded?.call(currentPage, repos, canLoadMore, warning);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int currentPage, List<GithubRepo> repos)? loading,
    TResult Function(int currentPage, List<GithubRepo> repos, bool canLoadMore,
            GetStaredReposWarning? warning)?
        loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(currentPage, repos, canLoadMore, warning);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StarredReposStateLoading value) loading,
    required TResult Function(_StarredReposStateLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StarredReposStateLoading value)? loading,
    TResult Function(_StarredReposStateLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _StarredReposStateLoaded implements StarredReposState {
  const factory _StarredReposStateLoaded(
      {required int currentPage,
      required List<GithubRepo> repos,
      required bool canLoadMore,
      GetStaredReposWarning? warning}) = _$_StarredReposStateLoaded;

  @override
  int get currentPage;
  @override
  List<GithubRepo> get repos;
  bool get canLoadMore;
  GetStaredReposWarning? get warning;
  @override
  @JsonKey(ignore: true)
  _$StarredReposStateLoadedCopyWith<_StarredReposStateLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
