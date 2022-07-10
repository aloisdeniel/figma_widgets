import 'package:flutter/widgets.dart';
import '../dart.dart';

class EdgeInsetsGeometryGenerator extends DartGenerator<EdgeInsetsGeometry> {
  const EdgeInsetsGeometryGenerator();
  @override
  String toDart(EdgeInsetsGeometry value, BuildContext context) {
    if (value is EdgeInsets) {
      return const EdgeInsetsGenerator().toDart(value, context);
    }

    return 'EdgeInsets.zero';
  }
}

class EdgeInsetsGenerator extends DartGenerator<EdgeInsets> {
  const EdgeInsetsGenerator();
  @override
  String toDart(EdgeInsets value, BuildContext context) {
    if (value.top == value.bottom &&
        value.top == value.right &&
        value.top == value.left) {
      if (value.top == 0.0) return 'EdgeInsets.zero';
      return 'EdgeInsets.all(${value.top})';
    }

    if (value.top == value.bottom && value.left == value.right) {
      final result = StringBuffer('EdgeInsets.symmetric(');
      if (value.left > 0.0) {
        result.write('horizontal: ${value.left},');
      }
      if (value.top > 0.0) {
        result.write('vertical: ${value.top},');
      }
      result.write(')');
      return result.toString();
    }

    final result = StringBuffer('EdgeInsets.only(');
    if (value.top > 0.0) {
      result.write('top: ${value.top},');
    }
    if (value.bottom > 0.0) {
      result.write('bottom: ${value.bottom},');
    }
    if (value.left > 0.0) {
      result.write('left: ${value.left},');
    }
    if (value.right > 0.0) {
      result.write('right: ${value.right},');
    }
    result.write(')');
    return result.toString();
  }
}
