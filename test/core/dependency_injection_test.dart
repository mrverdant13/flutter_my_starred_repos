import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/core/flavors.dart';
import 'package:test/test.dart';

void main() {
  group(
    '''
  
GIVEN an injector function''',
    () {
      const githubAuthConfig = GithubAuthConfig(
        clientId: 'clientId',
        clientSecret: 'clientSecret',
      );
      const appConfig = AppConfig(
        githubAuthConfig: githubAuthConfig,
      );
      for (final flavor in Flavor.values) {
        group(
          '''
  
AND the app config data
AND the ${flavor.tag} flavor
WHEN the injection process is triggered''',
          () {
            setUp(
              () async {
                getIt.reset();
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
                // ARRANGE

                // ACT

                // ASSERT
                expect(
                  getIt.isRegistered<Flavor>(),
                  true,
                );
                expect(kAppFlavor, flavor);
              },
            );

            test(
              '''

THEN the app congig should be injected
''',
              () async {
                // ARRANGE

                // ACT
                final registeredAppConfig = getIt<AppConfig>();

                // ASSERT
                expect(
                  registeredAppConfig,
                  appConfig,
                );
              },
            );
          },
        );
      }
    },
  );
}
