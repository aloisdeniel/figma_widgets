import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/alignment.dart';
import 'package:flutter_figma_widget/src/generators/widgets/widget.dart';
import '../dart.dart';

class StackGenerator extends DartGenerator<Stack> {
  const StackGenerator();
  @override
  String toDart(Stack value, BuildContext context) {
    final result = StringBuffer('Stack(');

    if (value.clipBehavior != Clip.hardEdge) {
      result.write("clipBehavior: ${value.clipBehavior},");
    }
    if (value.alignment != AlignmentDirectional.topStart) {
      final alignment =
          const AlignmentGeometryGenerator().toDart(value.alignment, context);
      result.write("alignment: $alignment,");
    }
    if (value.fit != StackFit.loose) {
      result.write("fit: ${value.fit},");
    }
    if (value.textDirection != null) {
      result.write("textDirection: ${value.textDirection},");
    }
    result.write("children: [");

    for (var child in value.children) {
      result.write(const WidgetGenerator().toDart(child, context));
      result.write(",");
    }

    result.write("],");
    result.write(")");
    return result.toString();
  }
}
