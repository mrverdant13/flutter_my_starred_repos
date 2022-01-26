import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import 'config.dart';
import 'flavors.dart';

final flavorPod = Provider<Flavor>(
  (_) => throw StateError(
    'The app flavor has not been initialized',
  ),
);

final appConfigPod = Provider<AppConfig>(
  (_) => throw StateError(
    'The app config has not been initialized',
  ),
);

final gqlClientPod = Provider<GraphQLClient>(
  (ref) => GraphQLClient(
    cache: GraphQLCache(),
    link: Link.from([
      AuthLink(
        getToken: () async {
          final credsStorage = ref.read(credsStoragePod);
          final creds = await credsStorage.get();
          final token = creds?.accessToken;
          return token == null ? null : 'Bearer $token';
        },
      ),
      HttpLink('https://api.github.com/graphql'),
    ]),
  ),
);

final dioPod = Provider(
  (ref) => Dio(),
);

Future<List<Override>> getInjectionOverrides({
  required Flavor flavor,
  required AppConfig appConfig,
}) async =>
    [
      flavorPod.overrideWithValue(flavor),
      appConfigPod.overrideWithValue(appConfig),
    ];
