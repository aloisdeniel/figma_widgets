import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/widgets/widget.dart';
import '../dart.dart';

class PositionedGenerator extends DartGenerator<Positioned> {
  const PositionedGenerator();
  @override
  String toDart(Positioned value, BuildContext context) {
    final result = StringBuffer('');

    if (value.top == 0.0 &&
        value.top == value.bottom &&
        value.top == value.left &&
        value.top == value.right) {
      result.write('Positioned.fill(');
    } else {
      result.write('Positioned(');
      if (value.top != null) {
        result.write("top: ${value.top},");
      }
      if (value.bottom != null) {
        result.write("bottom: ${value.bottom},");
      }
      if (value.left != null) {
        result.write("left: ${value.left},");
      }
      if (value.right != null) {
        result.write("right: ${value.right},");
      }
      if (value.width != null) {
        result.write("width: ${value.width},");
      }
      if (value.height != null) {
        result.write("height: ${value.height},");
      }
    }

    final child = const WidgetGenerator().toDart(value.child, context);
    result.write("child: $child,");

    result.write(")");
    return result.toString();
  }
}
