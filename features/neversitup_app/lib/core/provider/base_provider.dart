import 'package:flutter/cupertino.dart';

abstract class BaseProvider extends ChangeNotifier {
  ///ui pass event to provider
  ///[onEvent]
  void onEvent<T>(T event);
}
