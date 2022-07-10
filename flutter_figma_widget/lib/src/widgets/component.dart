import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/node.dart';

class FigmaComponent extends StatelessWidget {
  const FigmaComponent({
    super.key,
    required this.component,
  });

  factory FigmaComponent.fromSource(
    String source,
  ) {
    final result = parseFigmaWidget(source);
    if (result.isSuccess) {
      return FigmaComponent(
        component: result.value,
      );
    }

    throw result.failure('Parsing failed');
  }

  final Component component;

  @override
  Widget build(BuildContext context) {
    final result = FigmaNode(
      node: component.tree,
    );

    return result;
  }
}
