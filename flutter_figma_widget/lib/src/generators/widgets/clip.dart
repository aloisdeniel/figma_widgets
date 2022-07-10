import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/border_radius.dart';
import 'package:flutter_figma_widget/src/generators/widgets/widget.dart';
import '../dart.dart';

class ClipRRectGenerator extends DartGenerator<ClipRRect> {
  const ClipRRectGenerator();
  @override
  String toDart(ClipRRect value, BuildContext context) {
    final result = StringBuffer('ClipRRect(');
    if (value.borderRadius != null) {
      final borderRadius =
          const BorderRadiusGenerator().toDart(value.borderRadius!, context);
      result.write("borderRadius: $borderRadius,");
    }

    if (value.clipBehavior != Clip.hardEdge) {
      result.write("clipBehavior: ${value.clipBehavior},");
    }

    if (value.child != null) {
      final child = const WidgetGenerator().toDart(value.child!, context);
      result.write("child: $child,");
    }

    result.write(")");
    return result.toString();
  }
}
