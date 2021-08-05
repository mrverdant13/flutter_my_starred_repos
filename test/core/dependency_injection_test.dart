import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/core/flavors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';

void main() {
  group(
    '''

GIVEN a depencencies container''',
    () {
      test(
        '''

AND no interaction
WHEN the app flavor is accessed
THEN an exception is thrown
├─ THAT indicates that the flavor has not been initialized
''',
        () {
          // ARRANGE
          final container = ProviderContainer();

          // ACT
          Flavor action() => container.read(flavorPod);

          // ASSERT
          expect(
            action,
            throwsA(
              predicate(
                (e) => e is ProviderException && e.exception is StateError,
              ),
            ),
          );
        },
      );

      test(
        '''

AND no interaction
WHEN the app config is accessed
THEN an exception is thrown
├─ THAT indicates that the config has not been initialized
''',
        () {
          // ARRANGE
          final container = ProviderContainer();

          // ACT
          AppConfig action() => container.read(appConfigPod);

          // ASSERT
          expect(
            action,
            throwsA(
              predicate(
                (e) => e is ProviderException && e.exception is StateError,
              ),
            ),
          );
        },
      );

      group(
        '''

AND an injection overrides getter function''',
        () {
          // ARRANGE
          for (final flavor in Flavor.values) {
            group(
              '''

AND the ${flavor.tag} flavor
AND the ${flavor.tag} app config
WHEN the injection process is triggered''',
              () {
                // ARRANGE
                final appConfig = AppConfig(
                  githubAuthConfig: GithubAuthConfig(
                    clientId: 'clientId-${flavor.tag}',
                    clientSecret: 'clientSecret-${flavor.tag}',
                  ),
                );
                late ProviderContainer container;
                setUp(
                  () async {
                    final overrides = await getInjectionOverrides(
                      flavor: flavor,
                      appConfig: appConfig,
                    );
                    container = ProviderContainer(
                      overrides: overrides,
                    );
                  },
                );

                test(
                  '''

THEN the ${flavor.tag} flavor should be initialized
''',
                  () async {
                    // ACT
                    final result = container.read(flavorPod);

                    // ASSERT
                    expect(result, flavor);
                  },
                );

                test(
                  '''

THEN the app config should be initialized
''',
                  () async {
                    // ACT
                    final result = container.read(appConfigPod);

                    // ASSERT
                    expect(result, appConfig);
                  },
                );
              },
            );
          }
        },
      );
    },
  );
}
