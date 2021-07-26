import '../../domain/page.dart';

typedef Mapper<I, O> = O Function(I element);

extension ConvertiblePage<I> on Page<I> {
  Page<O> map<O>(Mapper<I, O> mapper) {
    return Page(
      lastPage: lastPage,
      elements: elements
          .map<O>(
            (i) => mapper(i),
          )
          .toList(),
    );
  }

  static const lastPageKey = 'page';
  static const elementsKey = 'elements';

  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(I element) elementToJson,
  ) =>
      {
        lastPageKey: lastPage,
        elementsKey: elements.map(elementToJson).toList(),
      };

  static Page<I> fromJson<I>(
    Map<String, dynamic> json,
    I Function(Map<String, dynamic> elementJson) elementFromJson,
  ) =>
      Page(
        lastPage: json[lastPageKey] as int,
        elements: (json[elementsKey] as List)
            .cast<Map<String, dynamic>>()
            .map<I>(elementFromJson)
            .toList(),
      );
}
