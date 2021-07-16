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
}
