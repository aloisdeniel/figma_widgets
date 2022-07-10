import 'package:flutter/widgets.dart';
import 'decorated.dart';

class FigmaAutoLayout extends StatelessWidget {
  const FigmaAutoLayout({
    super.key,
    this.direction = Axis.horizontal,
    this.overflow = Clip.hardEdge,
    this.padding = EdgeInsets.zero,
    this.spacing = 0.0,
    this.crossAlignItems = CrossAxisAlignment.start,
    this.autoChildren = const <Widget>[],
    this.absoluteChildren = const <Widget>[],
    this.cornerRadius = BorderRadius.zero,
    this.fill = const <Decoration>[],
  });

  final Axis direction;
  final Clip overflow;
  final EdgeInsets padding;
  final double spacing;
  final CrossAxisAlignment crossAlignItems;
  final List<Widget> autoChildren;
  final List<Widget> absoluteChildren;
  final BorderRadius cornerRadius;
  final List<Decoration> fill;

  @override
  Widget build(BuildContext context) {
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
      crossAxisAlignment: crossAlignItems,
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
        clipBehavior: overflow,
        children: [
          result,
          ...absoluteChildren,
        ],
      );
    }

    return FigmaAutoLayoutDirection(
      value: direction,
      child: FigmaDecorated(
        fill: fill,
        cornerRadius: cornerRadius,
        child: result,
      ),
    );
  }
}

class FigmaAutoLayoutDirection extends InheritedWidget {
  const FigmaAutoLayoutDirection({
    super.key,
    required super.child,
    required this.value,
  });

  final Axis value;

  static Axis of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<FigmaAutoLayoutDirection>()
            ?.value ??
        Axis.vertical;
  }

  @override
  bool updateShouldNotify(covariant FigmaAutoLayoutDirection oldWidget) {
    return oldWidget.value != value;
  }
}

class FigmaAutoLayoutPositioned extends StatelessWidget {
  const FigmaAutoLayoutPositioned({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.direction,
  });

  final Axis? direction;
  final FigmaAutoConstraints width;
  final FigmaAutoConstraints height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final direction = this.direction ?? FigmaAutoLayoutDirection.of(context);
    var result = child;
    switch (direction) {
      case Axis.vertical:

        /// Cross fit
        result = SizedBox(
          width: width.map(
            fillParent: () => double.infinity,
            hugContents: () => null,
            fixedSize: (size) => size,
          ),
          height: height.map(
            fillParent: () => double.infinity,
            hugContents: () => null,
            fixedSize: (size) => size,
          ),
          child: result,
        );

        /// Main fit
        height.map(
          hugContents: () {},
          fixedSize: (size) {},
          fillParent: () {
            result = Expanded(
              child: result,
            );
          },
        );

        break;
      case Axis.horizontal:

        /// Cross fit
        result = SizedBox(
          height: height.map(
            fillParent: () => double.infinity,
            hugContents: () => null,
            fixedSize: (size) => size,
          ),
          width: width.map(
            fillParent: () => double.infinity,
            hugContents: () => null,
            fixedSize: (size) => size,
          ),
          child: result,
        );

        /// Main fit
        width.map(
          hugContents: () {},
          fixedSize: (size) {},
          fillParent: () {
            result = Expanded(
              child: result,
            );
          },
        );
        break;
    }

    return result;
  }
}

abstract class FigmaAutoConstraints {
  const FigmaAutoConstraints();

  const factory FigmaAutoConstraints.fillParent() = FigmaFillParentConstraints;

  const factory FigmaAutoConstraints.hugContents() =
      FigmaHugContentsConstraints;

  const factory FigmaAutoConstraints.fixedSize(
    double size,
  ) = FigmaFixedSizeConstraints;

  K map<K>({
    required K Function() fillParent,
    required K Function() hugContents,
    required K Function(double size) fixedSize,
  }) {
    final value = this;
    if (value is FigmaFillParentConstraints) {
      return fillParent();
    }

    if (value is FigmaHugContentsConstraints) {
      return hugContents();
    }

    if (value is FigmaFixedSizeConstraints) {
      return fixedSize(value.size);
    }

    throw Exception();
  }
}

class FigmaFillParentConstraints extends FigmaAutoConstraints {
  const FigmaFillParentConstraints();
}

class FigmaHugContentsConstraints extends FigmaAutoConstraints {
  const FigmaHugContentsConstraints();
}

class FigmaFixedSizeConstraints extends FigmaAutoConstraints {
  const FigmaFixedSizeConstraints(this.size);

  final double size;
}
