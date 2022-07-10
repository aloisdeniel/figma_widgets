import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/dart.dart';

import 'color.dart';
import 'string.dart';

class TextStyleGenerator extends DartGenerator<TextStyle> {
  const TextStyleGenerator();
  @override
  String toDart(TextStyle value, BuildContext context) {
    final result = StringBuffer('TextStyle(');

    if (value.color != null) {
      final color = const ColorGenerator().toDart(value.color!, context);
      result.write("color: $color,");
    }
    if (value.fontSize != null) result.write("fontSize: ${value.fontSize},");
    if (value.fontFamily != null && value.fontFamily!.isNotEmpty) {
      final family = const StringGenerator().toDart(value.fontFamily!, context);
      result.write("fontFamily: $family,");
    }
    if (value.fontWeight != FontWeight.w400) {
      result.write("fontWeight: ${value.fontWeight},");
    }

    result.write(")");
    return result.toString();
  }
}
