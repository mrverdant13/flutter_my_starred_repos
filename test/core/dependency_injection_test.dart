import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/core/flavors.dart';
import 'package:test/test.dart';

void main() {
  group(
    '''

GIVEN an injector function
AND the app config data''',
    () {
      // ARRANGE
      const appConfig = AppConfig(
        githubAuthConfig: GithubAuthConfig(
          clientId: 'clientId',
          clientSecret: 'clientSecret',
        ),
      );

      for (final flavor in Flavor.values) {
        group(
          '''
  
AND the ${flavor.tag} flavor
WHEN the injection process is triggered''',
          () {
            setUp(
              () async {
                // ARRANGE
                getIt.reset();

                // ACT
                await injectDependencies(
                  config: appConfig,
                  flavor: flavor,
                );
              },
            );

            test(
              '''

THEN the flavor should be injected
''',
              () async {
                // ASSERT
                expect(getIt.isRegistered<Flavor>(), isTrue);
                expect(kAppFlavor, flavor);
              },
            );

            test(
              '''

THEN the app config should be injected
''',
              () async {
                // ASSERT
                final registeredAppConfig = getIt<AppConfig>();
                expect(registeredAppConfig, appConfig);
              },
            );
          },
        );
      }
    },
  );
}
