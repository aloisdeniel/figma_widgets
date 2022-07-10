import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/widgets/widget.dart';
import '../dart.dart';

class RowGenerator extends DartGenerator<Row> {
  const RowGenerator();
  @override
  String toDart(Row value, BuildContext context) {
    return const FlexGenerator().toDart(value, context);
  }
}

class ColumnGenerator extends DartGenerator<Column> {
  const ColumnGenerator();
  @override
  String toDart(Column value, BuildContext context) {
    return const FlexGenerator().toDart(value, context);
  }
}

class FlexGenerator extends DartGenerator<Flex> {
  const FlexGenerator();
  @override
  String toDart(Flex value, BuildContext context) {
    final result =
        StringBuffer(value.direction == Axis.horizontal ? 'Row(' : 'Column(');

    if (value.mainAxisAlignment != MainAxisAlignment.start) {
      result.write("mainAxisAlignment: ${value.mainAxisAlignment},");
    }

    if (value.mainAxisSize != MainAxisSize.max) {
      result.write("mainAxisSize: ${value.mainAxisSize},");
    }

    if (value.crossAxisAlignment != CrossAxisAlignment.center) {
      result.write("crossAxisAlignment: ${value.crossAxisAlignment},");
    }

    if (value.verticalDirection != VerticalDirection.down) {
      result.write("verticalDirection: ${value.verticalDirection},");
    }

    if (value.textDirection != null) {
      result.write("textDirection: ${value.textDirection},");
    }
    result.write("children: [");

    for (var child in value.children) {
      result.write(const WidgetGenerator().toDart(child, context));
      result.write(",");
    }

    result.write("],");
    result.write(")");
    return result.toString();
  }
}

class ExpandedGenerator extends DartGenerator<Expanded> {
  const ExpandedGenerator();
  @override
  String toDart(Expanded value, BuildContext context) {
    final result = StringBuffer('Expanded(');

    if (value.flex != 1.0) {
      result.write("flex: ${value.flex},");
    }

    final child = const WidgetGenerator().toDart(value.child, context);
    result.write("child: $child,");

    result.write(")");
    return result.toString();
  }
}

class FlexibleGenerator extends DartGenerator<Flexible> {
  const FlexibleGenerator();
  @override
  String toDart(Flexible value, BuildContext context) {
    final result = StringBuffer('Flexible(');

    if (value.fit != FlexFit.loose) {
      result.write("fit: ${value.fit},");
    }

    if (value.flex != 1.0) {
      result.write("flex: ${value.flex},");
    }

    final child = const WidgetGenerator().toDart(value.child, context);
    result.write("child: $child,");

    result.write(")");
    return result.toString();
  }
}
