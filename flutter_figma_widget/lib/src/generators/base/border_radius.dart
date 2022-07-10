import 'package:flutter/widgets.dart';
import '../dart.dart';

class BorderRadiusGenerator extends DartGenerator<BorderRadius> {
  const BorderRadiusGenerator();
  @override
  String toDart(BorderRadius value, BuildContext context) {
    if (value.bottomLeft == value.bottomRight &&
        value.bottomLeft == value.topLeft &&
        value.bottomLeft == value.topRight) {
      final radius = const RadiusGenerator().toDart(value.bottomLeft, context);
      return 'BorderRadius.all($radius)';
    }

    final result = StringBuffer('BorderRadius.only(');
    if (value.bottomLeft != Radius.zero) {
      final radius = const RadiusGenerator().toDart(value.bottomLeft, context);
      result.write('bottomLeft: $radius,');
    }
    if (value.bottomRight != Radius.zero) {
      final radius = const RadiusGenerator().toDart(value.bottomRight, context);
      result.write('bottomRight: $radius,');
    }
    if (value.topLeft != Radius.zero) {
      final radius = const RadiusGenerator().toDart(value.topLeft, context);
      result.write('topLeft: $radius,');
    }
    if (value.topRight != Radius.zero) {
      final radius = const RadiusGenerator().toDart(value.topRight, context);
      result.write('topRight: $radius,');
    }
    result.write(')');
    return result.toString();
  }
}

class RadiusGenerator extends DartGenerator<Radius> {
  const RadiusGenerator();
  @override
  String toDart(Radius value, BuildContext context) {
    if (value.x == value.y) {
      if (value.x == 0.0) return 'Radius.zero';
      return 'Radius.circular(${value.x})';
    }
    return 'Radius.elliptical(${value.x}, ${value.x})';
  }
}
