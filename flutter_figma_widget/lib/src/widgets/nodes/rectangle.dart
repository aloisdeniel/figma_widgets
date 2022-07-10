import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import '../data_provider.dart';
import 'decorated.dart';

class FigmaRectangle extends StatelessWidget {
  const FigmaRectangle({
    super.key,
    required this.node,
  });

  final TagNode node;

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);
    return FigmaDecorated(
      properties: properties,
      child: const SizedBox(),
    );
  }
}
