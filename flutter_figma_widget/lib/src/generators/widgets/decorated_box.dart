import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/decoration.dart';
import 'package:flutter_figma_widget/src/generators/widgets/widget.dart';
import '../dart.dart';

class DecoratedBoxGenerator extends DartGenerator<DecoratedBox> {
  const DecoratedBoxGenerator();
  @override
  String toDart(DecoratedBox value, BuildContext context) {
    final result = StringBuffer('DecoratedBox(');
    final decoration =
        const DecorationGenerator().toDart(value.decoration, context);
    result.write("decoration: $decoration,");
    if (value.child != null) {
      final child = const WidgetGenerator().toDart(value.child!, context);
      result.write("child: $child,");
    }

    result.write(")");
    return result.toString();
  }
}
