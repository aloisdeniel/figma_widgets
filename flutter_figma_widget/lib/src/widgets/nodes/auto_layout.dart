import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import '../data_provider.dart';
import 'decorated.dart';
import 'frame.dart';
import 'node.dart';
import 'data_conversion/data_conversion.dart';

class FigmaAutoLayout extends StatelessWidget {
  const FigmaAutoLayout({
    super.key,
    required this.node,
  });

  final TagNode node;

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);

    final overflowClip = properties['overflow'].asOverflowClip();
    final direction = properties['direction'].asAxis();
    final padding = properties['padding'].asEdgeInsets();
    final crossAxisAlignment =
        properties[_alignProperty(direction)].asCrossAxisAlignment();
    final spacing = properties['spacing'].asDouble();
    final allChildren = node.children.whereType<TagNode>();
    final autoChildren = allChildren
        .where((child) {
          final properties = context.resolveProperties(child);
          return properties['positioning'].asString() != 'absolute';
        })
        .map(
          (e) => FigmaAutoLayoutPositioned(
            direction: direction,
            node: e,
          ),
        )
        .toList();
    final absoluteChildren = allChildren
        .where((child) {
          final properties = context.resolveProperties(child);
          return properties['positioning'].asString() == 'absolute';
        })
        .map(
          (e) => FigmaFramePositioned(
            node: e,
          ),
        )
        .toList();

    final spacingWidget = () {
      if (spacing == 0) return null;
      switch (direction) {
        case Axis.vertical:
          return SizedBox(height: spacing);
        default:
          return SizedBox(width: spacing);
      }
    }();

    Widget result = Flex(
      direction: direction,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (spacingWidget == null) ...autoChildren,
        if (spacingWidget != null)
          for (var i = 0; i < autoChildren.length; i++) ...[
            if (i > 0) spacingWidget,
            autoChildren[i],
          ]
      ],
    );

    if (padding != EdgeInsets.zero) {
      result = Padding(
        padding: padding,
        child: result,
      );
    }

    if (absoluteChildren.isNotEmpty) {
      result = Stack(
        clipBehavior: overflowClip,
        children: [
          result,
          ...absoluteChildren,
        ],
      );
    }

    return FigmaDecorated(
      properties: properties,
      child: result,
    );
  }
}

class FigmaAutoLayoutPositioned extends StatelessWidget {
  const FigmaAutoLayoutPositioned({
    super.key,
    required this.direction,
    required this.node,
  });

  final Axis direction;
  final TagNode node;

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);
    final width = properties['width'];
    final height = properties['height'];

    Widget result = FigmaNode(
      node: node,
    );

    switch (direction) {
      case Axis.vertical:

        /// Cross fit
        result = SizedBox(
          width: width.asFillParent() ? double.infinity : width.asDouble(null),
          height: height.asDouble(null),
          child: result,
        );

        /// Main fit
        if (height.asFillParent()) {
          result = Expanded(
            child: result,
          );
        } else {}
        break;
      case Axis.horizontal:

        /// Cross fit
        result = SizedBox(
          width: width.asDouble(null),
          height:
              height.asFillParent() ? double.infinity : height.asDouble(null),
          child: result,
        );

        /// Main fit
        if (width.asFillParent()) {
          result = Expanded(
            child: result,
          );
        }
        break;
    }

    return result;
  }
}

String _alignProperty(Axis direction) {
  switch (direction) {
    case Axis.vertical:
      return 'horizontalAlignItems';
    case Axis.horizontal:
      return 'verticalAlignItems';
  }
}
