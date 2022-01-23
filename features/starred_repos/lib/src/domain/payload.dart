import 'package:freezed_annotation/freezed_annotation.dart';

part 'payload.freezed.dart';

@freezed
class Payload<D, W> with _$Payload<D, W> {
  const factory Payload(
    D data,
  ) = _Payload<D, W>;
  const factory Payload.withWarning({
    required D data,
    required W warning,
  }) = _PayloadWithWarning<D, W>;
}

@visibleForTesting
typedef PayloadWithoutWarning<D, W> = _Payload<D, W>;

@visibleForTesting
typedef PayloadWithWarning<D, W> = _PayloadWithWarning<D, W>;
