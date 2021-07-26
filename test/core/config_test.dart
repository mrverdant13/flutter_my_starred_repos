import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''
  
GIVEN a JSON representation of the app config
WHEN it is deserialized
THEN a coherent app config data holder is created
''',
    () {
      // ARRANGE
      const configYamlString = '''
githubAuthConfig:
  clientId: clientId
  clientSecret: clientSecret
''';
      const config = AppConfig(
        githubAuthConfig: GithubAuthConfig(
          clientId: 'clientId',
          clientSecret: 'clientSecret',
        ),
      );

      // ACT
      final result = AppConfig.fromYamlString(configYamlString);

      // ASSERT
      expect(result, config);
    },
  );
}
