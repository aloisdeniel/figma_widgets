import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/dart.dart';

class StringGenerator extends DartGenerator<String> {
  const StringGenerator();
  @override
  String toDart(String value, BuildContext context) {
    return "'${value.replaceAll("'", "\\'")}'";
  }
}
