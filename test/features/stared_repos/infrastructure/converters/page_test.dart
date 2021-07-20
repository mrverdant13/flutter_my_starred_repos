import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/features/stared_repos/domain/page.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/converters/page.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a page of integers
AND an integer to string mapper
WHEN it is mapped
THEN its elements should be transformed to strings
''',
    () async {
      // ARRANGE
      String mapper(int value) => '$value';
      const elementsCount = 5;
      final initialElements = List.generate(
        elementsCount,
        (idx) => idx,
      );
      const lastPage = 9;
      final initialPage = Page(
        lastPage: lastPage,
        elements: initialElements,
      );
      final expectedResultingElements = initialElements.map(mapper).toList();

      // ACT
      final resultingPage = initialPage.map(mapper);

      // ARRANGE
      expect(resultingPage, isA<Page>());
      expect(
        resultingPage,
        predicate<Page>(
          (page) {
            final isSamePage = page.lastPage == lastPage;
            final areExpectedElements = listEquals(
              page.elements,
              expectedResultingElements,
            );
            return isSamePage && areExpectedElements;
          },
        ),
      );
    },
  );
}
