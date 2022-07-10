import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/widgets/data_provider.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/data_conversion/data_conversion.dart';

import 'auto_layout.dart';
import 'frame.dart';
import 'rectangle.dart';
import 'text.dart';
import 'image.dart';

// https://www.figma.com/widget-docs/api/type-Transform
class FigmaNode extends StatelessWidget {
  const FigmaNode({
    super.key,
    required this.node,
  });

  final TagNode node;

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);
    final width = properties['width'];
    final height = properties['height'];

    Widget result = () {
      switch (node.identifier) {
        case 'AutoLayout':
          return FigmaAutoLayout(node: node);
        case 'Text':
          return FigmaText(node: node);
        case 'Image':
          return FigmaImage(node: node);
        case 'Frame':
          return FigmaFrame(node: node);
        case 'Rectangle':
          return FigmaRectangle(node: node);
        case 'Ellipse':
        case 'Star':
        case 'Line':
        case 'SVG':
        case 'Fragment':
        case 'Input':
        default:
          return const SizedBox();
      }
    }();

    if (width != null || height != null) {
      result = SizedBox(
        width: width.asDouble(null),
        height: height.asDouble(null),
        child: result,
      );
    }

    return result;
  }
}
