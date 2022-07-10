import 'package:figma_widget_parser/figma_widget_parser.dart';
import 'package:flutter/widgets.dart';

import 'basic.dart';

extension DecorationConversionExtension on Value? {
  BorderRadius asBorderRadius([BorderRadius fallback = BorderRadius.zero]) {
    return map(
      primitive: (value, orElse) {
        if (value is num) {
          return BorderRadius.all(Radius.circular(value.toDouble()));
        }

        return orElse();
      },
      object: (items, orElse) {
        final topLeft = items['topLeft'];
        final topRight = items['topRight'];
        final bottomLeft = items['bottomLeft'];
        final bottomRight = items['bottomRight'];
        if (topLeft != null ||
            topRight != null ||
            bottomLeft != null ||
            bottomRight != null) {
          return BorderRadius.only(
            topLeft: Radius.circular(topLeft.asDouble()!),
            topRight: Radius.circular(topRight.asDouble()!),
            bottomLeft: Radius.circular(bottomLeft.asDouble()!),
            bottomRight: Radius.circular(bottomRight.asDouble()!),
          );
        }
        return orElse();
      },
      orElse: () => fallback,
    );
  }

  List<Decoration> asFillDecorations(
      [List<Decoration> fallback = const <Decoration>[]]) {
    Decoration fromObject(Map<String, Value> properties) {
      final type = properties['type'].asString();

      switch (type) {
        case 'solid':
          return BoxDecoration(
            color: properties['color'].asColor(),
          );
        case 'gradient-linear':
          final gradientHandlePositions =
              properties['gradientHandlePositions'].asGradientHandlePositions();
          var begin = gradientHandlePositions[0];
          var end = gradientHandlePositions[1];
          final beginAlign = Alignment(
            (begin.dx - 0.5) * 2.0,
            (begin.dy - 0.5) * 2.0,
          );
          final endAlign = Alignment(
            (end.dx - 0.5) * 2.0,
            (end.dy - 0.5) * 2.0,
          );
          final gradientStops = properties['gradientStops'].asGradientStops();

          return BoxDecoration(
            gradient: LinearGradient(
              begin: beginAlign,
              end: endAlign,
              colors: gradientStops.map((x) => x.value).toList(),
              stops: gradientStops.map((x) => x.key).toList(),
              tileMode: TileMode.clamp,
            ),
          );
        default:
          return const BoxDecoration();
      }
    }

    return map(
      primitive: (value, orElse) {
        if (value is String) {
          return [
            BoxDecoration(
              color: value.asColor(),
            ),
          ];
        }
        return orElse();
      },
      object: (items, orElse) => [
        fromObject(items),
      ],
      array: (items, orElse) => [
        ...items.whereType<ObjectValue>().map((e) => fromObject(e.items)),
      ],
      orElse: () => fallback,
    );
  }

  List<Offset> asGradientHandlePositions() {
    return map(
      array: ((items, orElse) {
        return [
          ...items.map(
            (e) => e.asOffset(),
          ),
        ];
      }),
      orElse: () => const <Offset>[],
    );
  }

  List<MapEntry<double, Color>> asGradientStops() {
    return map(
      array: ((items, orElse) {
        return [
          ...items.whereType<ObjectValue>().map(
                (e) => MapEntry<double, Color>(
                  e.items['position'].asDouble()!,
                  e.items['color'].asColor() ?? const Color(0x00000000),
                ),
              ),
        ];
      }),
      orElse: () => const <MapEntry<double, Color>>[],
    );
  }

  Clip asOverflowClip([Clip fallback = Clip.hardEdge]) {
    return map(
      primitive: (value, orElse) {
        switch (value) {
          case 'visible':
            return Clip.none;
          default:
            return orElse();
        }
      },
      orElse: () => fallback,
    );
  }
}

extension ColorExtension on Object? {
  Color? asColor() {
    var value = this;
    if (value is String) {
      value = value.replaceFirst('#', '');
      if (value.length >= 8) {
        final r = value.substring(0, 2);
        final g = value.substring(2, 4);
        final b = value.substring(4, 6);
        final a = value.substring(6, 8);
        return Color.fromARGB(
          int.parse(a, radix: 16),
          int.parse(r, radix: 16),
          int.parse(g, radix: 16),
          int.parse(b, radix: 16),
        );
      } else if (value.length >= 6) {
        final r = value.substring(0, 2);
        final g = value.substring(2, 4);
        final b = value.substring(4, 6);
        return Color.fromARGB(
          255,
          int.parse(r, radix: 16),
          int.parse(g, radix: 16),
          int.parse(b, radix: 16),
        );
      } else if (value.length >= 3) {
        final r = value.substring(0, 1);
        final g = value.substring(1, 2);
        final b = value.substring(2, 3);
        return Color.fromARGB(
          255,
          int.parse('$r$r', radix: 16),
          int.parse('$g$g', radix: 16),
          int.parse('$b$b', radix: 16),
        );
      }
      return null;
    }
    if (value is PrimitiveValue) {
      return value.value.asColor();
    }
    if (value is ObjectValue) {
      final r = value.items['r'].asDouble()!;
      final g = value.items['g'].asDouble()!;
      final b = value.items['b'].asDouble()!;
      final a = value.items['a'].asDouble()!;
      return Color.fromARGB(
        (a * 255).toInt(),
        (r * 255).toInt(),
        (g * 255).toInt(),
        (b * 255).toInt(),
      );
    }
    if (value is Color) {
      return value;
    }
    return null;
  }
}
