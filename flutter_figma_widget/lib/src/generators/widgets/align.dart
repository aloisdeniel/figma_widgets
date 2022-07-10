import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/alignment.dart';
import 'package:flutter_figma_widget/src/generators/dart.dart';

import 'widget.dart';

class AlignGenerator extends DartGenerator<Align> {
  const AlignGenerator();
  @override
  String toDart(Align value, BuildContext context) {
    final result = StringBuffer('Align(');

    if (value.alignment != Alignment.center) {
      final alignment =
          const AlignmentGeometryGenerator().toDart(value.alignment, context);
      result.write("alignment: $alignment,");
    }

    if (value.widthFactor != null) {
      result.write("widthFactor: ${value.widthFactor},");
    }

    if (value.heightFactor != null) {
      result.write("heightFactor: ${value.heightFactor},");
    }

    if (value.child != null) {
      final child = const WidgetGenerator().toDart(value.child!, context);
      result.write("child: $child,");
    }

    result.write(")");
    return result.toString();
  }
}
