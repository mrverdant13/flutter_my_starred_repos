import 'package:flutter_app_template/core/flavors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    '''
GIVEN a correct flavor tag
WHEN the tag is parsed to a flavor
THEN the correct flavor is returned
''',
    () async {
      // ARRANGE
      const inputFlavorTag = 'DEV';
      const outputFlavor = Flavor.dev;

      // ACT
      final result = inputFlavorTag.flavor;

      // ASSERT
      expect(result, outputFlavor);
    },
  );

  test(
    '''
GIVEN an incorrect flavor tag
WHEN the tag is parsed to a flavor
THEN an unsupported error is thrown
''',
    () async {
      // ARRANGE
      const inputFlavorTag = 'FAIL';

      // ACT
      Flavor action() => inputFlavorTag.flavor;

      // ASSERT
      expect(action, throwsUnsupportedError);
    },
  );

  test(
    '''
GIVEN all available flavors
WHEN they are parsed to their tags
THEN the correct string tags are obtained
''',
    () async {
      // ARRANGE
      final testMap = {
        Flavor.dev: FlavorTag.dev,
        Flavor.prod: FlavorTag.prod,
        Flavor.stg: FlavorTag.stg,
      };

      for (final flavorKeyValue in testMap.entries) {
        final flavor = flavorKeyValue.key;
        final expectedFlavorTag = flavorKeyValue.value;

        // ACT
        final flavorTag = flavor.tag;

        // ASSERT
        expect(flavorTag, expectedFlavorTag);
      }
    },
  );
}
