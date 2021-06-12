import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../core/dependency_injection.dart';
import '../../../../application/cubit/users/users_cubit.dart';

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
