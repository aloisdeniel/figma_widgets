import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/decorated.dart';

class FigmaImage extends StatelessWidget {
  const FigmaImage({
    super.key,
    this.src,
    this.cornerRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
    this.name,
  });

  final BorderRadius cornerRadius;
  final String? src;
  final BoxFit fit;
  final String? name;

  @override
  Widget build(BuildContext context) {
    var src = this.src;

    if (src == null) {
      return const SizedBox();
    }

    if (src == '<Add image URL here>') {
      src = 'https://via.placeholder.com/100x100.png';
    }

    return FigmaDecorated(
      cornerRadius: cornerRadius,
      child: Image.network(
        src,
        fit: fit,
        semanticLabel: name,
      ),
    );
  }
}
