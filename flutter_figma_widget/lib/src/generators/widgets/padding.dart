import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/edge_insets.dart';
import 'package:flutter_figma_widget/src/generators/widgets/widget.dart';
import '../dart.dart';

class PaddingGenerator extends DartGenerator<Padding> {
  const PaddingGenerator();
  @override
  String toDart(Padding value, BuildContext context) {
    final result = StringBuffer('Padding(');
    final padding =
        const EdgeInsetsGeometryGenerator().toDart(value.padding, context);
    result.write("padding: $padding,");
    if (value.child != null) {
      final child = const WidgetGenerator().toDart(value.child!, context);
      result.write("child: $child,");
    }

    result.write(")");
    return result.toString();
  }
}
