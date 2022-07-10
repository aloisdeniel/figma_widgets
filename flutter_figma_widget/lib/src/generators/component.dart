import 'package:dart_style/dart_style.dart';
import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/widgets/widget.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/node.dart';
import 'dart.dart';

class ComponentGenerator extends DartGenerator<Component> {
  const ComponentGenerator();
  @override
  String toDart(Component value, BuildContext context) {
    final result = StringBuffer();

    result.writeln('class ${value.name} extends StatelessWidget {');
    result.writeln('const ${value.name}({ super.key, });');

    result.writeln('@override');
    result.writeln('Widget build(BuildContext context) {');

    final tree = const WidgetGenerator().toDart(
      FigmaNode(node: value.tree),
      context,
    );

    result.writeln('return $tree;');
    result.writeln('}');
    result.writeln('}');

    return DartFormatter().format(result.toString());
  }
}
