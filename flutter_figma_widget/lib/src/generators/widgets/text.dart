import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/base/string.dart';
import 'package:flutter_figma_widget/src/generators/base/text_style.dart';
import '../dart.dart';

class TextGenerator extends DartGenerator<Text> {
  const TextGenerator();
  @override
  String toDart(Text value, BuildContext context) {
    final result = StringBuffer('Text(');
    final data = const StringGenerator().toDart(value.data!, context);
    result.write("$data,");
    if (value.style != null) {
      final style = const TextStyleGenerator().toDart(value.style!, context);
      result.write("style: $style,");
    }
    result.write(")");
    return result.toString();
  }
}
