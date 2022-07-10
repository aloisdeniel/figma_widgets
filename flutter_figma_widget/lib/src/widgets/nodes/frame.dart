import 'package:flutter/widgets.dart';
import 'decorated.dart';

class FigmaFrame extends StatelessWidget {
  const FigmaFrame({
    super.key,
    this.overflow = Clip.hardEdge,
    this.children = const <Widget>[],
    this.cornerRadius = BorderRadius.zero,
    this.fill = const <Decoration>[],
  });

  final Clip overflow;
  final List<Widget> children;
  final BorderRadius cornerRadius;
  final List<Decoration> fill;

  @override
  Widget build(BuildContext context) {
    return FigmaDecorated(
      fill: fill,
      cornerRadius: cornerRadius,
      child: Stack(
        clipBehavior: overflow,
        children: children,
      ),
    );
  }
}

class FigmaFramePositioned extends StatelessWidget {
  const FigmaFramePositioned({
    super.key,
    required this.x,
    required this.y,
    required this.child,
  });

  final FigmaFrameConstraints x;
  final FigmaFrameConstraints y;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    x.map(
      startEnd: (leftOffset, rightOffset) {
        y.map(
          startEnd: (topOffset, bottomOffset) {
            result = Positioned(
              left: leftOffset,
              right: rightOffset,
              top: topOffset,
              bottom: bottomOffset,
              child: result,
            );
          },
          end: (bottomOffset, height) {
            result = Positioned(
              left: leftOffset,
              right: rightOffset,
              bottom: bottomOffset,
              height: height,
              child: result,
            );
          },
          start: (topOffset, height) {
            result = Positioned(
              left: leftOffset,
              right: rightOffset,
              top: topOffset,
              height: height,
              child: result,
            );
          },
          center: (yOffset, height) {
            if (height != null) {
              result = SizedBox(
                height: height,
              );
            }
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
      end: (rightOffset, width) {
        y.map(
          startEnd: (topOffset, bottomOffset) {
            result = Positioned(
              right: rightOffset,
              top: topOffset,
              bottom: bottomOffset,
              width: width,
              child: result,
            );
          },
          end: (bottomOffset, height) {
            result = Positioned(
              right: rightOffset,
              bottom: bottomOffset,
              height: height,
              width: width,
              child: result,
            );
          },
          start: (topOffset, height) {
            result = Positioned(
              right: rightOffset,
              top: topOffset,
              height: height,
              width: width,
              child: result,
            );
          },
          center: (yOffset, height) {
            if (height != null) {
              result = SizedBox(
                height: height,
              );
            }
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
      start: (leftOffset, width) {
        y.map(
          startEnd: (topOffset, bottomOffset) {
            result = Positioned(
              left: leftOffset,
              top: topOffset,
              bottom: bottomOffset,
              width: width,
              child: result,
            );
          },
          end: (bottomOffset, height) {
            result = Positioned(
              left: leftOffset,
              bottom: bottomOffset,
              height: height,
              width: width,
              child: result,
            );
          },
          start: (topOffset, height) {
            result = Positioned(
              left: leftOffset,
              top: topOffset,
              height: height,
              width: width,
              child: result,
            );
          },
          center: (yOffset, height) {
            if (height != null) {
              result = SizedBox(
                height: height,
              );
            }
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
      center: (xOffset, width) {
        y.map(
          startEnd: (topOffset, bottomOffset) {
            if (width != null) {
              result = SizedBox(
                width: width,
              );
            }
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
          end: (bottomOffset, height) {
            if (xOffset != 0) {
              result = Transform.translate(
                offset: Offset(xOffset, 0),
                child: result,
              );
            }
            result = Positioned(
              bottom: bottomOffset,
              height: height,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: result,
              ),
            );
          },
          start: (topOffset, height) {
            if (xOffset != 0) {
              result = Transform.translate(
                offset: Offset(xOffset, 0),
                child: result,
              );
            }
            result = Positioned(
              top: topOffset,
              height: height,
              child: Align(
                alignment: Alignment.topCenter,
                child: result,
              ),
            );
          },
          center: (yOffset, height) {
            if (height != null || width != null) {
              result = SizedBox(
                height: height,
                width: width,
              );
            }
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

abstract class FigmaFrameConstraints {
  const FigmaFrameConstraints();

  const factory FigmaFrameConstraints.startEnd([
    double startOffset,
    double endOffset,
  ]) = FigmaFrameStartEndConstraints;

  const factory FigmaFrameConstraints.start([
    double offset,
    double? size,
  ]) = FigmaFrameStartConstraints;

  const factory FigmaFrameConstraints.end([
    double offset,
    double? size,
  ]) = FigmaFrameEndConstraints;

  const factory FigmaFrameConstraints.center([
    double offset,
    double? size,
  ]) = FigmaFrameCenterConstraints;

  K map<K>({
    required K Function(double startOffset, double endOffset) startEnd,
    required K Function(double offset, double? size) start,
    required K Function(double offset, double? size) end,
    required K Function(double offset, double? size) center,
  }) {
    final value = this;
    if (value is FigmaFrameStartEndConstraints) {
      return startEnd(value.startOffset, value.endOffset);
    }

    if (value is FigmaFrameStartConstraints) {
      return start(value.offset, value.size);
    }

    if (value is FigmaFrameEndConstraints) {
      return end(value.offset, value.size);
    }

    if (value is FigmaFrameCenterConstraints) {
      return center(value.offset, value.size);
    }

    throw Exception();
  }
}

class FigmaFrameStartEndConstraints extends FigmaFrameConstraints {
  const FigmaFrameStartEndConstraints([
    this.startOffset = 0.0,
    this.endOffset = 0.0,
  ]);
  final double startOffset;
  final double endOffset;
}

class FigmaFrameStartConstraints extends FigmaFrameConstraints {
  const FigmaFrameStartConstraints([
    this.offset = 0.0,
    this.size,
  ]);
  final double offset;
  final double? size;
}

class FigmaFrameEndConstraints extends FigmaFrameConstraints {
  const FigmaFrameEndConstraints([
    this.offset = 0.0,
    this.size,
  ]);
  final double offset;
  final double? size;
}

class FigmaFrameCenterConstraints extends FigmaFrameConstraints {
  const FigmaFrameCenterConstraints([
    this.offset = 0.0,
    this.size,
  ]);
  final double offset;
  final double? size;
}
