import 'package:freezed_annotation/freezed_annotation.dart';

part 'payload.freezed.dart';

@freezed
class Payload<D, W> with _$Payload<D, W> {
  // coverage:ignore-start
  const factory Payload(
    D data,
  ) = PayloadWithoutWarning<D, W>;
  const factory Payload.withWarning({
    required D data,
    required W warning,
  }) = PayloadWithWarning<D, W>;
  // coverage:ignore-end
}
