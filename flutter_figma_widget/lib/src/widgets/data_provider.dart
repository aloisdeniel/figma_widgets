import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FigmaDataProvider extends InheritedWidget {
  const FigmaDataProvider({
    super.key,
    required super.child,
    required this.data,
  });

  final Map<String, Value> data;

  Value? resolve(Value value) {
    if (value is PrimitiveValue ||
        value is ArrayValue ||
        value is ObjectValue) {
      return value;
    }
    if (value is ReferenceValue) {
      final resolved = data[value.name];
      if (resolved == null) return null;
      return resolve(resolved);
    }

    return null;
  }

  @override
  bool updateShouldNotify(covariant FigmaDataProvider oldWidget) {
    return mapEquals(data, oldWidget.data);
  }
}

extension BuildContextExtensions on BuildContext {
  Map<String, Value?> resolveProperties(TagNode node) {
    final provider = dependOnInheritedWidgetOfExactType<FigmaDataProvider>();
    return Map<String, Value?>.fromEntries(
      node.properties.whereType<TagNodeMemberProperty>().map(
            (e) => MapEntry(e.name, provider?.resolve(e.value) ?? e.value),
          ),
    );
  }

  Value? resolveValue(Value? value) {
    if (value == null) return null;
    if (value is PrimitiveValue ||
        value is ArrayValue ||
        value is ObjectValue) {
      return value;
    }

    final provider = dependOnInheritedWidgetOfExactType<FigmaDataProvider>();
    return provider?.resolve(value);
  }
}
