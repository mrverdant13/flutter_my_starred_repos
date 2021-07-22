import 'package:freezed_annotation/freezed_annotation.dart';

part 'payload.freezed.dart';

@freezed
class Payload<D, W> with _$Payload<D, W> {
  const factory Payload(
    D data,
  ) = _Payload;
  const factory Payload.withWarning({
    required D data,
    required W warning,
  }) = _PayloadWithWarning<D, W>;

  const Payload._();

  bool get hasWarning => this is _PayloadWithWarning;
  W? get warning => when<W?>(
        (_) => null,
        withWarning: (_, w) => w,
      );
}
