import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/node.dart';
import '../data_provider.dart';
import 'data_conversion/data_conversion.dart';
import 'decorated.dart';

class FigmaFrame extends StatelessWidget {
  const FigmaFrame({
    super.key,
    required this.node,
  });

  final TagNode node;

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);
    final overflowClip = properties['overflow'].asOverflowClip();
    return FigmaDecorated(
      properties: properties,
      child: Stack(
        clipBehavior: overflowClip,
        children: [
          ...node.children.whereType<TagNode>().map(
                (e) => FigmaFramePositioned(
                  node: e,
                ),
              )
        ],
      ),
    );
  }
}

class FigmaFramePositioned extends StatelessWidget {
  const FigmaFramePositioned({
    super.key,
    required this.node,
  });

  final TagNode node;

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);
    final x = properties['x'];
    final y = properties['y'];

    Widget result = FigmaNode(
      node: node,
    );

    x._mapX(
      leftRight: (leftOffset, rightOffset) {
        y._mapY(
          topBottom: (topOffset, bottomOffset) {
            result = Positioned(
              left: leftOffset,
              right: rightOffset,
              top: topOffset,
              bottom: bottomOffset,
              child: result,
            );
          },
          bottom: (bottomOffset) {
            result = Positioned(
              left: leftOffset,
              right: rightOffset,
              bottom: bottomOffset,
              child: result,
            );
          },
          top: (topOffset) {
            result = Positioned(
              left: leftOffset,
              right: rightOffset,
              top: topOffset,
              child: result,
            );
          },
          center: (yOffset) {
            if (yOffset != 0) {
              result = Transform.translate(
                offset: Offset(0, yOffset),
                child: result,
              );
            }
            result = Positioned(
              left: leftOffset,
              right: rightOffset,
              top: 0,
              bottom: 0,
              child: Align(
                // ignore: todo
                alignment: Alignment.center, // TODO only vertical
                child: result,
              ),
            );
          },
        );
      },
      right: (rightOffset) {
        y._mapY(
          topBottom: (topOffset, bottomOffset) {
            result = Positioned(
              right: rightOffset,
              top: topOffset,
              bottom: bottomOffset,
              child: result,
            );
          },
          bottom: (bottomOffset) {
            result = Positioned(
              right: rightOffset,
              bottom: bottomOffset,
              child: result,
            );
          },
          top: (topOffset) {
            result = Positioned(
              right: rightOffset,
              top: topOffset,
              child: result,
            );
          },
          center: (yOffset) {
            if (yOffset != 0) {
              result = Transform.translate(
                offset: Offset(0, yOffset),
                child: result,
              );
            }
            result = Positioned(
              right: rightOffset,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: result,
              ),
            );
          },
        );
      },
      left: (leftOffset) {
        y._mapY(
          topBottom: (topOffset, bottomOffset) {
            result = Positioned(
              left: leftOffset,
              top: topOffset,
              bottom: bottomOffset,
              child: result,
            );
          },
          bottom: (bottomOffset) {
            result = Positioned(
              left: leftOffset,
              bottom: bottomOffset,
              child: result,
            );
          },
          top: (topOffset) {
            result = Positioned(
              left: leftOffset,
              top: topOffset,
              child: result,
            );
          },
          center: (yOffset) {
            if (yOffset != 0) {
              result = Transform.translate(
                offset: Offset(0, yOffset),
                child: result,
              );
            }
            result = Positioned(
              left: leftOffset,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: result,
              ),
            );
          },
        );
      },
      center: (xOffset) {
        y._mapY(
          topBottom: (topOffset, bottomOffset) {
            if (xOffset != 0) {
              result = Transform.translate(
                offset: Offset(xOffset, 0),
                child: result,
              );
            }
            result = Positioned(
              top: topOffset,
              bottom: bottomOffset,
              child: Align(
                // ignore: todo
                alignment: Alignment.center, // TODO only horizontal
                child: result,
              ),
            );
          },
          bottom: (bottomOffset) {
            if (xOffset != 0) {
              result = Transform.translate(
                offset: Offset(xOffset, 0),
                child: result,
              );
            }
            result = Positioned(
              bottom: bottomOffset,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: result,
              ),
            );
          },
          top: (topOffset) {
            if (xOffset != 0) {
              result = Transform.translate(
                offset: Offset(xOffset, 0),
                child: result,
              );
            }
            result = Positioned(
              top: topOffset,
              child: Align(
                alignment: Alignment.topCenter,
                child: result,
              ),
            );
          },
          center: (yOffset) {
            if (yOffset != 0 || xOffset != 0) {
              result = Transform.translate(
                offset: Offset(xOffset, yOffset),
                child: result,
              );
            }
            result = Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: result,
              ),
            );
          },
        );
      },
    );

    return result;
  }
}

extension FramePositionExtension on Value? {
  K _mapX<K>({
    required K Function(double leftOffset, double rightOffset) leftRight,
    required K Function(double offset) right,
    required K Function(double offset) left,
    required K Function(double offset) center,
  }) {
    return map(
      object: (items, orElse) {
        final type = items['type'].asString();
        switch (type) {
          case 'left-right':
            final leftOffset = items['leftOffset'].asDouble(0.0)!;
            final rightOffset = items['rightOffset'].asDouble(0.0)!;
            return leftRight(leftOffset, rightOffset);
          case 'right':
            final offset = items['offset'].asDouble(0.0)!;
            return right(offset);
          case 'left':
            final offset = items['offset'].asDouble(0.0)!;
            return left(offset);
          case 'center':
            final offset = items['offset'].asDouble(0.0)!;
            return center(offset);
          default:
            return left(0.0);
        }
      },
      primitive: (value, orElse) {
        if (value is num) {
          final leftOffset = value.toDouble();
          return left(leftOffset);
        }

        return left(0.0);
      },
      orElse: () => left(0.0),
    );
  }

  K _mapY<K>({
    required K Function(double topOffset, double bottomOffset) topBottom,
    required K Function(double offset) bottom,
    required K Function(double offset) top,
    required K Function(double offset) center,
  }) {
    return map(
      object: (items, orElse) {
        final type = items['type'].asString();
        switch (type) {
          case 'top-bottom':
            final topOffset = items['topOffset'].asDouble(0.0)!;
            final bottomOffset = items['bottomOffset'].asDouble(0.0)!;
            return topBottom(topOffset, bottomOffset);
          case 'bottom':
            final offset = items['offset'].asDouble(0.0)!;
            return bottom(offset);
          case 'top':
            final offset = items['offset'].asDouble(0.0)!;
            return top(offset);
          case 'center':
            final offset = items['offset'].asDouble(0.0)!;
            return center(offset);
          default:
            return top(0.0);
        }
      },
      primitive: (value, orElse) {
        if (value is num) {
          final leftOffset = value.toDouble();
          return top(leftOffset);
        }

        return top(0.0);
      },
      orElse: () => top(0.0),
    );
  }
}
