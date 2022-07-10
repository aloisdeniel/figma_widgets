import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';

import 'data_conversion/data_conversion.dart';

class FigmaDecorated extends StatelessWidget {
  const FigmaDecorated({
    super.key,
    required this.properties,
    required this.child,
  });

  final Map<String, Value?> properties;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    final decorations = properties['fill'].asFillDecorations();
    for (var decoration in decorations) {
      result = DecoratedBox(
        decoration: decoration,
        child: result,
      );
    }

    final borderRadius = properties['cornerRadius'].asBorderRadius();
    if (borderRadius != BorderRadius.zero) {
      result = ClipRRect(
        borderRadius: borderRadius,
        child: result,
      );
    }

    return result;
  }
}
