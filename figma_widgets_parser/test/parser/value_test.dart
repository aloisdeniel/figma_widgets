import 'package:figma_widgets_parser/figma_widgets_parser.dart';

import 'package:petitparser/reflection.dart';
import 'package:test/test.dart';

final definition = FigmaWidgetParserDefinition();
final parser = definition.build(start: definition.value);

void main() {
  test('linter', () {
    expect(linter(parser), isEmpty);
  });

  group('primitive', () {
    test('null', () {
      final result = parser.parse('null');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');

      expect(result.value, isA<PrimitiveValue>());
      final value = result.value as PrimitiveValue;
      expect(value.value, isNull);
    });
    group('boolean', () {
      test('true', () {
        final result = parser.parse('true');
        expect(result.isSuccess, isTrue, reason: 'isSuccess');

        expect(result.value, isA<PrimitiveValue>());
        final value = result.value as PrimitiveValue;
        expect(value.value, equals(true));
      });
      test('false', () {
        final result = parser.parse('false');
        expect(result.isSuccess, isTrue, reason: 'isSuccess');

        expect(result.value, isA<PrimitiveValue>());
        final value = result.value as PrimitiveValue;
        expect(value.value, equals(false));
      });
    });
    group('number', () {
      test('integer', () {
        final result = parser.parse('10');
        expect(result.isSuccess, isTrue, reason: 'isSuccess');

        expect(result.value, isA<PrimitiveValue>());
        final value = result.value as PrimitiveValue;
        expect(value.value, equals(10));
      });
      test('float', () {
        final result = parser.parse('1.0');
        expect(result.isSuccess, isTrue, reason: 'isSuccess');

        expect(result.value, isA<PrimitiveValue>());
        final value = result.value as PrimitiveValue;
        expect(value.value, equals(1.0));
      });
    });
    group('string', () {
      test('empty', () {
        final result = parser.parse('""');
        expect(result.isSuccess, isTrue, reason: 'isSuccess');

        expect(result.value, isA<PrimitiveValue>());
        final value = result.value as PrimitiveValue;
        expect(value.value, equals(""));
      });
      test('literal', () {
        final result = parser.parse('"Hello world"');
        expect(result.isSuccess, isTrue, reason: 'isSuccess');
        expect(result.value, equals(Value.primitive("Hello world")));
      });
    });
  });
  test('reference', () {
    final result = parser.parse('props');
    expect(result.isSuccess, isTrue, reason: 'isSuccess');
    expect(result.value, equals(Value.reference("props")));
  });
  group('object', () {
    test('empty', () {
      final result = parser.parse('{}');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');
      expect(result.value, equals(Value.object({})));
    });

    test('with primitive properties', () {
      final result =
          parser.parse('{ hello: "World", success: 1, really: true }');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');
      expect(
          result.value,
          equals(
            Value.object(
              {
                'hello': Value.primitive('World'),
                'success': Value.primitive(1),
                'really': Value.primitive(true),
              },
            ),
          ));
    });

    test('with trailing comma', () {
      final result =
          parser.parse('{ hello: "World", success: 1, really: true, }');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');
      expect(
          result.value,
          equals(
            Value.object(
              {
                'hello': Value.primitive('World'),
                'success': Value.primitive(1),
                'really': Value.primitive(true),
              },
            ),
          ));
    });

    test('with embedded objects', () {
      final result = parser.parse(
          '{ hello: "World", child1: { hello1: "World1" }, child2: { hello2: "World2",  child3: { hello3: "World3" } } }');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');
      expect(
          result.value,
          equals(
            Value.object(
              {
                'hello': Value.primitive('World'),
                'child1': Value.object(
                  {
                    'hello1': Value.primitive('World1'),
                  },
                ),
                'child2': Value.object(
                  {
                    'hello2': Value.primitive('World2'),
                    'child3': Value.object(
                      {
                        'hello3': Value.primitive('World3'),
                      },
                    ),
                  },
                ),
              },
            ),
          ));
    });
  });

  group('array', () {
    test('empty', () {
      final result = parser.parse('[]');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');
      expect(result.value, equals(Value.array([])));
    });

    test('with primitive items', () {
      final result = parser.parse('[ "World", 1,  true ]');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');
      expect(
        result.value,
        equals(
          Value.array(
            [
              Value.primitive('World'),
              Value.primitive(1),
              Value.primitive(true),
            ],
          ),
        ),
      );
    });

    test('with trailing comma', () {
      final result = parser.parse('[ "World", 1,  true, ]');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');
      expect(
        result.value,
        equals(
          Value.array(
            [
              Value.primitive('World'),
              Value.primitive(1),
              Value.primitive(true),
            ],
          ),
        ),
      );
    });

    test('with embedded objects', () {
      final result = parser.parse(
          '[ "World", 1,  true, [ {hello: "World"  }, props ], {hello1: "World1"} ]');
      expect(result.isSuccess, isTrue, reason: 'isSuccess');
      expect(
        result.value,
        equals(
          Value.array(
            [
              Value.primitive('World'),
              Value.primitive(1),
              Value.primitive(true),
              Value.array([
                Value.object(
                  {
                    'hello': Value.primitive('World'),
                  },
                ),
                Value.reference('props'),
              ]),
              Value.object(
                {
                  'hello1': Value.primitive('World1'),
                },
              ),
            ],
          ),
        ),
      );
    });
  });
}
