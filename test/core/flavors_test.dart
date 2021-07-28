import 'package:flutter_my_starred_repos/core/flavors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    '''

GIVEN all available flavor tags
WHEN they are parsed to their flavors
THEN the correct flavors are returned
''',
    () async {
      // ARRANGE
      final testMap = {
        FlavorTag.dev: Flavor.dev,
        FlavorTag.prod: Flavor.prod,
        FlavorTag.stg: Flavor.stg,
      };

      for (final flavorKeyValue in testMap.entries) {
        // ARRANGE
        final flavorTag = flavorKeyValue.key;
        final expectedFlavor = flavorKeyValue.value;

        // ACT
        final result = flavorTag.flavor;

        // ASSERT
        expect(result, expectedFlavor);
      }
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
THEN the correct string tags are returned
''',
    () async {
      // ARRANGE
      final testMap = {
        Flavor.dev: FlavorTag.dev,
        Flavor.prod: FlavorTag.prod,
        Flavor.stg: FlavorTag.stg,
      };

      for (final flavorKeyValue in testMap.entries) {
        // ARRANGE
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
