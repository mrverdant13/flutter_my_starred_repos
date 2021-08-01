import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config.dart';
import 'flavors.dart';

final flavorPod = Provider<Flavor>(
  (_) => Flavor.prod,
);

final appConfigPod = Provider<AppConfig>(
  (ref) => AppConfig.fromYamlString(''),
);
