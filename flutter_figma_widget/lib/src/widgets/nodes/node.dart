import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/widgets/data_provider.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/data_conversion/data_conversion.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/svg.dart';

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

  Widget _buildFrameChild(
    BuildContext context,
    TagNode node,
  ) {
    final properties = context.resolveProperties(node);
    return FigmaFramePositioned(
      x: properties['x']
          .asHorizontalFrameConstraints(properties['width'].asDouble(null)),
      y: properties['y']
          .asVerticalFrameConstraints(properties['height'].asDouble(null)),
      child: FigmaNode(node: node),
    );
  }

  Widget _buildFrame(
    BuildContext context,
    Map<String, Value?> properties,
  ) {
    return FigmaFrame(
      fill: properties['fill'].asFillDecorations(),
      cornerRadius: properties['cornerRadius'].asBorderRadius(),
      overflow: properties['overflow'].asOverflowClip(),
      children: [
        ...node.children
            .whereType<TagNode>()
            .map((e) => _buildFrameChild(context, e))
      ],
    );
  }

  Widget _buildAutoChild(
    BuildContext context,
    TagNode node,
    Axis direction,
  ) {
    final properties = context.resolveProperties(node);
    return FigmaAutoLayoutPositioned(
      direction: direction,
      width: properties['width'].asAutoConstraints(),
      height: properties['height'].asAutoConstraints(),
      child: FigmaNode(node: node),
    );
  }

  Widget _buildAutoLayout(
    BuildContext context,
    Map<String, Value?> properties,
  ) {
    final direction = properties['direction'].asAxis();
    String _alignProperty(Axis direction) {
      switch (direction) {
        case Axis.vertical:
          return 'horizontalAlignItems';
        case Axis.horizontal:
          return 'verticalAlignItems';
      }
    }

    final allChildren = node.children.whereType<TagNode>();
    final autoChildren = allChildren
        .where((child) {
          final properties = context.resolveProperties(child);
          return properties['positioning'].asString() != 'absolute';
        })
        .map((e) => _buildAutoChild(context, e, direction))
        .toList();
    final absoluteChildren = allChildren
        .where((child) {
          final properties = context.resolveProperties(child);
          return properties['positioning'].asString() == 'absolute';
        })
        .map((e) => _buildFrameChild(context, e))
        .toList();
    return FigmaAutoLayout(
      direction: direction,
      fill: properties['fill'].asFillDecorations(),
      cornerRadius: properties['cornerRadius'].asBorderRadius(),
      overflow: properties['overflow'].asOverflowClip(),
      padding: properties['padding'].asEdgeInsets(),
      spacing: properties['spacing'].asDouble()!,
      crossAlignItems:
          properties[_alignProperty(direction)].asCrossAxisAlignment(),
      autoChildren: autoChildren,
      absoluteChildren: absoluteChildren,
    );
  }

  Widget _buildRectangle(
    BuildContext context,
    Map<String, Value?> properties,
  ) {
    return FigmaRectangle(
      fill: properties['fill'].asFillDecorations(),
      cornerRadius: properties['cornerRadius'].asBorderRadius(),
    );
  }

  Widget _buildText(
    BuildContext context,
    Map<String, Value?> properties,
    TagNode node,
  ) {
    return FigmaText(
      node.innerText,
      color: properties['fill'].asColor(),
      fontSize: properties['fontSize'].asDouble(null),
      fontFamily: properties['fontFamily'].asString(null),
      fontWeight: properties['fontWeight'].asFontWeight(),
    );
  }

  Widget _buildImage(
    BuildContext context,
    Map<String, Value?> properties,
  ) {
    return FigmaImage(
      cornerRadius: properties['cornerRadius'].asBorderRadius(),
      src: properties['src'].asString(),
      name: properties['name'].asString(),
    );
  }

  Widget _buildSvg(
    BuildContext context,
    Map<String, Value?> properties,
  ) {
    return FigmaSvg(
      properties['src'].asString() ?? '',
      name: properties['name'].asString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);

    Widget result = () {
      switch (node.identifier) {
        case 'AutoLayout':
          return _buildAutoLayout(context, properties);
        case 'Text':
          return _buildText(context, properties, node);
        case 'Image':
          return _buildImage(context, properties);
        case 'Frame':
          return _buildFrame(context, properties);
        case 'Rectangle':
          return _buildRectangle(context, properties);
        case 'SVG':
          return _buildSvg(context, properties);
        case 'Ellipse':
        case 'Line':
        case 'Fragment':
        case 'Input':
        default:
          return const SizedBox();
      }
    }();

    return result;
  }
}
