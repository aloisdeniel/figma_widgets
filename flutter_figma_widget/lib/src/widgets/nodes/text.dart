import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/widgets/data_provider.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/data_conversion/data_conversion.dart';

class FigmaText extends StatelessWidget {
  const FigmaText({
    super.key,
    required this.node,
  });

  final TagNode node;

  @override
  Widget build(BuildContext context) {
    final properties = context.resolveProperties(node);
    final text = node.innerText;
    final color = properties['fill'].asColor();
    final fontSize = properties['fontSize'].asDouble(null);
    final fontFamily = properties['fontFamily'].asString(null);
    final fontWeight = properties['fontWeight'].asFontWeight();

    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
