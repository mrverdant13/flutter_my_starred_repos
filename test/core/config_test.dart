import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''
  
GIVEN a JSON representation of the app config
WHEN it is deserialized
THEN a coherent app config data holder should be created
''',
    () {
      // ARRANGE
      const appConfigYamlString = '''
githubAuthConfig:
  clientId: clientId
  clientSecret: clientSecret
''';
      const expectedAppConfig = AppConfig(
        githubAuthConfig: GithubAuthConfig(
          clientId: 'clientId',
          clientSecret: 'clientSecret',
        ),
      );

      // ACT
      final result = AppConfig.fromYamlString(appConfigYamlString);

      // ASSERT
      expect(result, expectedAppConfig);
    },
  );
}
