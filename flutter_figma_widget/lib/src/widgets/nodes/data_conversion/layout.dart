import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/auto_layout.dart';
import 'package:flutter_figma_widget/src/widgets/nodes/frame.dart';

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

  FigmaAutoConstraints asAutoConstraints(
      [FigmaAutoConstraints fallback =
          const FigmaAutoConstraints.hugContents()]) {
    return map(
      primitive: (value, orElse) {
        if (value == 'fill-parent') {
          return const FigmaAutoConstraints.fillParent();
        }
        if (value == 'hug-contents') {
          return const FigmaAutoConstraints.hugContents();
        }
        if (value is num) {
          return FigmaAutoConstraints.fixedSize(value.toDouble());
        }

        return orElse();
      },
      orElse: () => fallback,
    );
  }

  FigmaFrameConstraints asHorizontalFrameConstraints(double? width,
      [FigmaFrameConstraints fallback = const FigmaFrameConstraints.start(0)]) {
    return map(
      object: (items, orElse) {
        final type = items['type'].asString();
        switch (type) {
          case 'left-right':
            final leftOffset = items['leftOffset'].asDouble(0.0)!;
            final rightOffset = items['rightOffset'].asDouble(0.0)!;
            return FigmaFrameConstraints.startEnd(leftOffset, rightOffset);
          case 'right':
            final offset = items['offset'].asDouble(0.0)!;
            return FigmaFrameConstraints.end(offset, width);
          case 'left':
            final offset = items['offset'].asDouble(0.0)!;
            return FigmaFrameConstraints.start(offset, width);
          case 'center':
            final offset = items['offset'].asDouble(0.0)!;
            return FigmaFrameConstraints.center(offset, width);
          default:
            return FigmaFrameConstraints.start(0.0, width);
        }
      },
      primitive: (value, orElse) {
        if (value is num) {
          final leftOffset = value.toDouble();
          return FigmaFrameConstraints.start(leftOffset, width);
        }

        return FigmaFrameConstraints.start(0.0, width);
      },
      orElse: () => FigmaFrameConstraints.start(0.0, width),
    );
  }

  FigmaFrameConstraints asVerticalFrameConstraints(double? height,
      [FigmaFrameConstraints fallback = const FigmaFrameConstraints.start(0)]) {
    return map(
      object: (items, orElse) {
        final type = items['type'].asString();
        switch (type) {
          case 'top-bottom':
            final topOffset = items['topOffset'].asDouble(0.0)!;
            final bottomOffset = items['bottomOffset'].asDouble(0.0)!;
            return FigmaFrameConstraints.startEnd(topOffset, bottomOffset);
          case 'bottom':
            final offset = items['offset'].asDouble(0.0)!;
            return FigmaFrameConstraints.end(offset, height);
          case 'top':
            final offset = items['offset'].asDouble(0.0)!;
            return FigmaFrameConstraints.start(offset, height);
          case 'center':
            final offset = items['offset'].asDouble(0.0)!;
            return FigmaFrameConstraints.center(offset, height);
          default:
            return FigmaFrameConstraints.start(0.0, height);
        }
      },
      primitive: (value, orElse) {
        if (value is num) {
          final leftOffset = value.toDouble();
          return FigmaFrameConstraints.start(leftOffset, height);
        }

        return FigmaFrameConstraints.start(0.0, height);
      },
      orElse: () => FigmaFrameConstraints.start(0.0, height),
    );
  }
}
