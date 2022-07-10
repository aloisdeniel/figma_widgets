import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';

extension ImageConversionExtension on Value? {
  BoxFit asBoxFit([BoxFit fallback = BoxFit.cover]) {
    return map(
      primitive: (value, orElse) {
        switch (value) {
          case 'fit':
            return BoxFit.contain;
          case 'fill':
            return BoxFit.cover;
          default:
            return orElse();
        }
      },
      orElse: () => fallback,
    );
  }
}
