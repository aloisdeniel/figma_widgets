import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';

extension TextConversionExtension on Value? {
  TextAlign asTextAlignment([TextAlign fallback = TextAlign.left]) {
    return map(
      primitive: (value, orElse) {
        switch (value) {
          case 'right':
            return TextAlign.right;
          case 'center':
            return TextAlign.center;
          case 'justified':
            return TextAlign.justify;
          default:
            return TextAlign.left;
        }
      },
      orElse: () => fallback,
    );
  }

  FontWeight asFontWeight([FontWeight fallback = FontWeight.w400]) {
    return map(
      primitive: (value, orElse) {
        if (value is num) {
          final index = (value ~/ 100) - 1;
          if (index > 0 && index < FontWeight.values.length) {
            return FontWeight.values[index];
          }
        }
        return orElse();
      },
      orElse: () => fallback,
    );
  }
}
