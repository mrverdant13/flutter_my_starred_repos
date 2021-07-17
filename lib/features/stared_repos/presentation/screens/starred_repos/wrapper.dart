part of 'screen.dart';

/// A wrapper widget that injects the required elements for the
/// [StarredReposScreen] to work.
class _Wrapper extends StatelessWidget {
  /// Creates a [StarredReposScreen] wrapper widget.
  ///
  /// The actual screen content should be built within the [builder].
  const _Wrapper({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider<StarredReposCubit>(
            create: (context) => getIt(),
          ),
        ],
        builder: (context, child) => builder(context),
      );
}
