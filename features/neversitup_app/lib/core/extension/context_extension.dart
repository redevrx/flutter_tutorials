import 'package:flutter/material.dart';
import 'package:neversitup_app/core/constant.dart';

extension ContextExtension on BuildContext {
  Size get deviceSize => mDeviceSize;

  ThemeData get theme => Theme.of(this);
}
