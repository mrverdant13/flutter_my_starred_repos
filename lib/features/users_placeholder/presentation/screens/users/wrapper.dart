part of 'screen.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersCubit = ref.watch(usersCubitPod);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersCubit>.value(
          value: usersCubit..load(),
        ),
      ],
      child: Builder(
        builder: builder,
      ),
    );
  }
}
