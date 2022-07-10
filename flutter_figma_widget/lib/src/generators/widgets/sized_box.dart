import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/num.dart';
import 'package:flutter_figma_widget/src/generators/widgets/widget.dart';
import '../dart.dart';

class SizedBoxGenerator extends DartGenerator<SizedBox> {
  const SizedBoxGenerator();
  @override
  String toDart(SizedBox value, BuildContext context) {
    final result = StringBuffer('SizedBox(');
    if (value.width != null) {
      result.write("width: ${value.width!.toDart()},");
    }
    if (value.height != null) {
      result.write("height: ${value.height!.toDart()},");
    }
    if (value.child != null) {
      final child = const WidgetGenerator().toDart(value.child!, context);
      result.write("child: $child,");
    }

    result.write(")");
    return result.toString();
  }
}
