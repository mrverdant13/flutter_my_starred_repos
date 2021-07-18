part of 'screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider<UsersCubit>(
            create: (context) => getIt()..load(),
          ),
        ],
        builder: (context, child) => builder(context),
      );
}
