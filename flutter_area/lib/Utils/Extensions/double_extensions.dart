import '../constants.dart';

extension DoubleExtension on double {
  double ratioW() {
    return this / (kIsPc ? 1440 : 393) * kDeviceWidth;
  }

  double ratioH() {
    return this / (kIsPc ? 1024 : 852) * kDeviceWidth;
  }
}
