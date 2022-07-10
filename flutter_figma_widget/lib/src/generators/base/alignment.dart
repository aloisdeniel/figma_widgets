import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/generators/dart.dart';

class AlignmentGeometryGenerator extends DartGenerator<AlignmentGeometry> {
  const AlignmentGeometryGenerator();
  @override
  String toDart(AlignmentGeometry value, BuildContext context) {
    if (value is Alignment) {
      return const AlignmentGenerator().toDart(value, context);
    }
    if (value is AlignmentDirectional) {
      return const AlignmentDirectionalGenerator().toDart(value, context);
    }
    return 'Alignment.center';
  }
}

class AlignmentGenerator extends DartGenerator<Alignment> {
  const AlignmentGenerator();
  @override
  String toDart(Alignment value, BuildContext context) {
    if (value == Alignment.bottomCenter) return 'Alignment.bottomCenter';
    if (value == Alignment.bottomLeft) return 'Alignment.bottomLeft';
    if (value == Alignment.bottomRight) return 'Alignment.bottomRight';
    if (value == Alignment.center) return 'Alignment.center';
    if (value == Alignment.centerLeft) return 'Alignment.centerLeft';
    if (value == Alignment.centerRight) return 'Alignment.centerRight';
    if (value == Alignment.topCenter) return 'Alignment.topCenter';
    if (value == Alignment.topLeft) return 'Alignment.topLeft';
    if (value == Alignment.topRight) return 'Alignment.topRight';
    return 'Alignment(${value.x},${value.y})';
  }
}

class AlignmentDirectionalGenerator
    extends DartGenerator<AlignmentDirectional> {
  const AlignmentDirectionalGenerator();
  @override
  String toDart(AlignmentDirectional value, BuildContext context) {
    if (value == AlignmentDirectional.bottomCenter) {
      return 'AlignmentDirectional.bottomCenter';
    }
    if (value == AlignmentDirectional.bottomStart) {
      return 'AlignmentDirectional.bottomStart';
    }
    if (value == AlignmentDirectional.bottomEnd) {
      return 'AlignmentDirectional.bottomEnd';
    }
    if (value == AlignmentDirectional.center) {
      return 'AlignmentDirectional.center';
    }
    if (value == AlignmentDirectional.centerStart) {
      return 'AlignmentDirectional.centerStart';
    }
    if (value == AlignmentDirectional.centerEnd) {
      return 'AlignmentDirectional.centerEnd';
    }
    if (value == AlignmentDirectional.topCenter) {
      return 'AlignmentDirectional.topCenter';
    }
    if (value == AlignmentDirectional.topStart) {
      return 'AlignmentDirectional.topStart';
    }
    if (value == AlignmentDirectional.topEnd) {
      return 'AlignmentDirectional.topEnd';
    }
    return 'AlignmentDirectional(${value.start},${value.y})';
  }
}
