import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/widgets/clip.dart';
import 'package:flutter_figma_widget/src/generators/widgets/decorated_box.dart';
import 'package:flutter_figma_widget/src/generators/widgets/flex.dart';
import 'package:flutter_figma_widget/src/generators/widgets/stack.dart';

import '../dart.dart';
import 'align.dart';
import 'padding.dart';
import 'positioned.dart';
import 'sized_box.dart';
import 'text.dart';
import 'image.dart';
import 'transform.dart';

class WidgetGenerator extends DartGenerator<Widget> {
  const WidgetGenerator();

  static const generators = <DartGenerator>[
    AlignGenerator(),
    ClipRRectGenerator(),
    DecoratedBoxGenerator(),
    RowGenerator(),
    ColumnGenerator(),
    FlexGenerator(),
    ExpandedGenerator(),
    FlexibleGenerator(),
    ImageGenerator(),
    PaddingGenerator(),
    PositionedGenerator(),
    SizedBoxGenerator(),
    StackGenerator(),
    TextGenerator(),
    TransformGenerator(),
  ];

  @override
  String toDart(Widget value, BuildContext context) {
    final generator = generators.firstWhere(
      (x) => x.type == value.runtimeType,
      orElse: () => const BuiltWidgetGenerator(),
    );
    return generator.toDart(value, context);
  }
}

class BuiltWidgetGenerator extends DartGenerator<Widget> {
  const BuiltWidgetGenerator();

  @override
  String toDart(Widget value, BuildContext context) {
    if (value is StatelessWidget) {
      return const WidgetGenerator().toDart(
        // ignore: invalid_use_of_protected_member
        value.build(context),
        context,
      );
    }

    if (value is StatefulWidget) {
      return const WidgetGenerator().toDart(
        // ignore: invalid_use_of_protected_member
        value.createState().build(context),
        context,
      );
    }
    throw Exception();
  }
}
