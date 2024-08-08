import 'package:neversitup_app/core/constant.dart';

extension SizeExtension on double {
  double get h {
    return (mDeviceSize.height * this) / 100.0;
  }

  double get w {
    return (mDeviceSize.width * this) / 100.0;
  }
}

extension SizeExtensionInt on int {
  double get h {
    return (mDeviceSize.height * this) / 100.0;
  }

  double get w {
    return (mDeviceSize.width * this) / 100.0;
  }
}
