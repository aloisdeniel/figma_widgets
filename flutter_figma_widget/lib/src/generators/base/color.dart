import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/dart.dart';

class ColorGenerator extends DartGenerator<Color> {
  const ColorGenerator();
  @override
  String toDart(Color value, BuildContext context) {
    return 'const Color(0x${value.value.toRadixString(16)})';
  }
}
