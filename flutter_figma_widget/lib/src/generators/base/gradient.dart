import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/dart.dart';

import 'alignment.dart';
import 'color.dart';

class GradientGenerator extends DartGenerator<Gradient> {
  const GradientGenerator();
  @override
  String toDart(Gradient value, BuildContext context) {
    if (value is LinearGradient) {
      return const LinearGradientGenerator().toDart(value, context);
    }

    return 'LinearGradient()';
  }
}

class LinearGradientGenerator extends DartGenerator<LinearGradient> {
  const LinearGradientGenerator();
  @override
  String toDart(LinearGradient value, BuildContext context) {
    final result = StringBuffer('LinearGradient(');
    final begin =
        const AlignmentGeometryGenerator().toDart(value.begin, context);
    result.write('begin: $begin,');
    final end = const AlignmentGeometryGenerator().toDart(value.end, context);
    result.write('end: $end,');
    if (value.tileMode != TileMode.clamp) {
      result.write('tileMode: ${value.tileMode},');
    }
    if (value.colors.isNotEmpty) {
      result.write('colors: [');
      for (var c in value.colors) {
        final color = const ColorGenerator().toDart(c, context);
        result.write(color);
        result.write(',');
      }
      result.write('],');
    }

    if (value.stops != null && value.stops!.isNotEmpty) {
      result.write('stops: [');
      for (var s in value.stops!) {
        result.write('$s,');
      }
      result.write('],');
    }

    result.write(')');
    return result.toString();
  }
}
