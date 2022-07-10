import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';

import 'basic.dart';

extension LayoutConversionExtension on Value? {
  EdgeInsets asEdgeInsets([EdgeInsets fallback = EdgeInsets.zero]) {
    return map(
      primitive: (value, orElse) {
        if (value is num) {
          return EdgeInsets.all(value.toDouble());
        }

        return orElse();
      },
      object: (items, orElse) {
        final vertical = items['vertical'];
        final horizontal = items['horizontal'];
        if (vertical != null || horizontal != null) {
          return EdgeInsets.symmetric(
            vertical: vertical.asDouble()!,
            horizontal: horizontal.asDouble()!,
          );
        }
        final left = items['left'];
        final right = items['right'];
        final top = items['top'];
        final bottom = items['bottom'];
        if (left != null || right != null || top != null || bottom != null) {
          return EdgeInsets.only(
            left: left.asDouble()!,
            right: right.asDouble()!,
            top: top.asDouble()!,
            bottom: bottom.asDouble()!,
          );
        }
        return orElse();
      },
      orElse: () => fallback,
    );
  }

  Axis asAxis([Axis fallback = Axis.horizontal]) {
    return map(
      primitive: (value, orElse) {
        switch (value) {
          case 'vertical':
            return Axis.vertical;
          default:
            return orElse();
        }
      },
      orElse: () => fallback,
    );
  }

  CrossAxisAlignment asCrossAxisAlignment(
      [CrossAxisAlignment fallback = CrossAxisAlignment.start]) {
    return map(
      primitive: (value, orElse) {
        switch (value) {
          case 'start':
            return CrossAxisAlignment.start;
          case 'end':
            return CrossAxisAlignment.end;
          case 'baseline':
            return CrossAxisAlignment.baseline;
          case 'center':
            return CrossAxisAlignment.center;
          default:
            return orElse();
        }
      },
      orElse: () => fallback,
    );
  }

  bool asFillParent() {
    return map(
      primitive: (value, orElse) => value == 'fill-parent',
      orElse: () => false,
    );
  }
}
