import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/core/flavors.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/core/dependency_injection.dart';
import 'package:graphql/client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

final dioPod = Provider<Dio>(
  (ref) => Dio()
    ..interceptors.addAll([
      ref.watch(authInterceptorPod),
      ref.watch(etagsInterceptorPod),
    ]),
);

Future<List<Override>> getInjectionOverrides({
  required Flavor flavor,
  required AppConfig appConfig,
}) async =>
    [
      flavorPod.overrideWithValue(flavor),
      appConfigPod.overrideWithValue(appConfig),
    ];
