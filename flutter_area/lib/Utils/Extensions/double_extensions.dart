import 'package:flutter/foundation.dart' show kIsWeb;

import '../contants.dart';

extension DoubleExtension on double {
  double ratioW() {
    return this / (kIsWeb ? 1440 : 393) * kDeviceWidth;
  }

  double ratioH() {
    return this / (kIsWeb ? 1024 : 852) * kDeviceWidth;
  }
}
