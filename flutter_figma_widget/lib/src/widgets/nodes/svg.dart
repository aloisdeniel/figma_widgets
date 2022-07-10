import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/decorated.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FigmaSvg extends StatelessWidget {
  const FigmaSvg(
    this.src, {
    super.key,
    this.cornerRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
    this.name,
  });

  final BorderRadius cornerRadius;
  final String src;
  final BoxFit fit;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return FigmaDecorated(
      cornerRadius: cornerRadius,
      child: SvgPicture.string(
        src,
        semanticsLabel: name,
      ),
    );
  }
}
