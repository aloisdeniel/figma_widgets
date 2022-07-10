import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';

extension BasicConversionExtension on Value? {
  double? asDouble([double? fallback = 0.0]) {
    return map(
      primitive: (value, orElse) => value is num ? value.toDouble() : orElse(),
      orElse: () => fallback,
    );
  }

  String? asString([String? fallback = '']) {
    return map(
      primitive: (value, orElse) => value?.toString() ?? orElse(),
      orElse: () => fallback,
    );
  }

  Offset asOffset([Offset fallback = Offset.zero]) {
    return map(
      object: ((items, orElse) {
        return Offset(
          items['x'].asDouble()!,
          items['y'].asDouble()!,
        );
      }),
      orElse: () => fallback,
    );
  }
}
