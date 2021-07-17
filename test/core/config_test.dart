import 'package:flutter_app_template/core/config.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''
  
GIVEN a JSON representation of the app config''',
    () {
      // ARRANGE
      const configJson = <String, dynamic>{
        'githubAuthConfig': {
          'clientId': 'clientId',
          'clientSecret': 'clientSecret',
        },
      };
      const config = AppConfig(
        githubAuthConfig: GithubAuthConfig(
          clientId: 'clientId',
          clientSecret: 'clientSecret',
        ),
      );

      // ACT
      final result = AppConfig.fromJson(configJson);

      // ASSERT
      expect(result, config);
    },
  );
}
