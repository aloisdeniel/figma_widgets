import 'package:flutter/widgets.dart';

abstract class DartGenerator<T> {
  const DartGenerator();

  Type get type => T;

  String toDart(T value, BuildContext context);
}
