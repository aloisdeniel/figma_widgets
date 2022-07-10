import 'package:flutter/widgets.dart';
import 'decorated.dart';

class FigmaRectangle extends StatelessWidget {
  const FigmaRectangle({
    super.key,
    this.cornerRadius = BorderRadius.zero,
    this.fill = const <Decoration>[],
  });

  final BorderRadius cornerRadius;
  final List<Decoration> fill;

  @override
  Widget build(BuildContext context) {
    return FigmaDecorated(
      fill: fill,
      cornerRadius: cornerRadius,
      child: const SizedBox(),
    );
  }
}
