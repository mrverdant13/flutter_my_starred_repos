part of 'screen.dart';

/// A wrapper widget that injects the required elements for the
/// [StarredReposScreen] to work.
class _Wrapper extends ConsumerWidget {
  /// Creates a [StarredReposScreen] wrapper widget.
  ///
  /// The actual screen content should be built within the [builder].
  const _Wrapper({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final starredReposCubit = ref.watch(starredReposCubitPod);
    return MultiBlocProvider(
      providers: [
        BlocProvider<StarredReposCubit>.value(
          value: starredReposCubit..load(),
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
