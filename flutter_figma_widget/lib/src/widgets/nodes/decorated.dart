import 'package:flutter/widgets.dart';

class FigmaDecorated extends StatelessWidget {
  const FigmaDecorated({
    super.key,
    required this.child,
    this.cornerRadius = BorderRadius.zero,
    this.fill = const <Decoration>[],
  });

  final BorderRadius cornerRadius;
  final List<Decoration> fill;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    for (var decoration in fill) {
      result = DecoratedBox(
        decoration: decoration,
        child: result,
      );
    }

    if (cornerRadius != BorderRadius.zero) {
      result = ClipRRect(
        borderRadius: cornerRadius,
        child: result,
      );
    }

    return result;
  }
}
