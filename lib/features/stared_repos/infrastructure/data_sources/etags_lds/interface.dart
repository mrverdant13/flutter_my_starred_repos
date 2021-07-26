abstract class PagesEtagsLDS {
  const PagesEtagsLDS();

  Future<String?> get({
    required int page,
  });

  Future<void> set({
    required int page,
    required String etag,
  });
}
