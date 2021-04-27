import 'dependency_injection.dart';

Flavor get kAppFlavor => getIt<Flavor>();

enum Flavor {
  dev,
  prod,
  stg,
}

abstract class FlavorTag {
  static const dev = 'DEV';
  static const prod = 'PROD';
  static const stg = 'STG';
}

extension ExtendedFlavorTag on String {
  static const _tagToFlavor = {
    FlavorTag.dev: Flavor.dev,
    FlavorTag.prod: Flavor.prod,
    FlavorTag.stg: Flavor.stg,
  };

  Flavor get flavor {
    if (!_tagToFlavor.containsKey(this)) {
      throw UnsupportedError(
        'The provided string does not map to a flavor.',
      );
    }
    return _tagToFlavor[this]!;
  }
}

extension ExtendedFlavor on Flavor {
  String get tag {
    switch (this) {
      case Flavor.dev:
        return FlavorTag.dev;
      case Flavor.prod:
        return FlavorTag.prod;
      case Flavor.stg:
        return FlavorTag.stg;
    }
  }
}
