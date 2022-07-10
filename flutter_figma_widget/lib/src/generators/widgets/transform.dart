import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/alignment.dart';
import 'package:flutter_figma_widget/src/generators/dart.dart';

import 'widget.dart';

class TransformGenerator extends DartGenerator<Transform> {
  const TransformGenerator();
  @override
  String toDart(Transform value, BuildContext context) {
    final result = StringBuffer('');
    final x = value.transform.storage[12];
    final y = value.transform.storage[13];
    final isTranslate = (x != 0.0 || y != 0.0) &&
        [0, 5, 10, 5].every((i) => value.transform.storage[i] == 1.0) &&
        [1, 2, 3, 4, 6, 7, 8, 9, 11, 14]
            .every((i) => value.transform.storage[i] == 0.0);
    if (isTranslate) {
      result.write('Transform.translate(');
      result.write('offset: Offset($x, $y),');
    } else {
      result.write('Transform(');
      result.write('transform: Matrix4(');
      for (var v in value.transform.storage) {
        result.write('$v,');
      }
      result.write('),');
    }

    if (value.alignment != null) {
      final alignment =
          const AlignmentGeometryGenerator().toDart(value.alignment!, context);
      result.write("alignment: $alignment,");
    }

    if (value.child != null) {
      final child = const WidgetGenerator().toDart(value.child!, context);
      result.write("child: $child,");
    }

    result.write(")");
    return result.toString();
  }
}
