import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import '../data_provider.dart';

import 'data_conversion/data_conversion.dart';

class FigmaImage extends StatelessWidget {
  const FigmaImage({
    super.key,
    required this.node,
  });

  final TagNode node;

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);
    var src = properties['src'].asString();

    if (src == null) {
      return const SizedBox();
    }

    if (src == '<Add image URL here>') {
      src = 'https://via.placeholder.com/100x100.png';
    }

    return Image.network(src);
  }
}
