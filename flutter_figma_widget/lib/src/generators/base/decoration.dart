import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/gradient.dart';
import '../dart.dart';
import 'color.dart';

class DecorationGenerator extends DartGenerator<Decoration> {
  const DecorationGenerator();
  @override
  String toDart(Decoration value, BuildContext context) {
    if (value is BoxDecoration) {
      return const BoxDecorationGenerator().toDart(value, context);
    }

    return 'BoxDecoration()';
  }
}

class BoxDecorationGenerator extends DartGenerator<BoxDecoration> {
  const BoxDecorationGenerator();
  @override
  String toDart(BoxDecoration value, BuildContext context) {
    final result = StringBuffer('BoxDecoration(');
    if (value.color != null) {
      final color = const ColorGenerator().toDart(value.color!, context);
      result.write('color: $color,');
    }
    if (value.gradient != null) {
      final gradient =
          const GradientGenerator().toDart(value.gradient!, context);
      result.write('gradient: $gradient,');
    }

    result.write(')');
    return result.toString();
  }
}
