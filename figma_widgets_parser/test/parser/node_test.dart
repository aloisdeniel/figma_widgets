import 'package:figma_widgets_parser/figma_widgets_parser.dart';
import 'package:petitparser/petitparser.dart';

import 'package:petitparser/reflection.dart';
import 'package:test/test.dart';

final definition = FigmaWidgetParserDefinition();
final parser = definition.build(start: definition.tagNode);
final propertyParser = definition.build(start: definition.tagNodeProperty);
final propertiesParser = definition.build(start: definition.tagNodeProperties);

extension ResultExt on Result {
  String reason() => isFailure ? '$message at ${this.position}' : '';
}

void main() {
  test('linter', () {
    expect(linter(parser), isEmpty);
  });

  group('properties', () {
    test('string member', () {
      final result = propertyParser.parse('text="Hello World"');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(
        result.value,
        equals(
          TagNodeProperty.member(
            'text',
            Value.primitive('Hello World'),
          ),
        ),
      );
    });

    test('dynamic member', () {
      final result = propertyParser.parse('visible={true}');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(
        result.value,
        equals(
          TagNodeProperty.member(
            'visible',
            Value.primitive(true),
          ),
        ),
      );
    });

    test('multiple', () {
      final result =
          propertiesParser.parse('text="Hello World" visible={true}');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(
        result.value[0],
        equals(
          TagNodeProperty.member(
            'text',
            Value.primitive('Hello World'),
          ),
        ),
      );
      expect(
        result.value[1],
        equals(
          TagNodeProperty.member(
            'visible',
            Value.primitive(true),
          ),
        ),
      );
    });
  });

  group('wihout children', () {
    test('without properties', () {
      final result = parser.parse('<Text />');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(result.value, equals(Node.tag('Text')));
    });

    test('with one string property', () {
      final result = parser.parse('<Text text="Hello World"  />');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(
        result.value,
        equals(
          Node.tag(
            'Text',
            properties: [
              TagNodeProperty.member(
                'text',
                Value.primitive('Hello World'),
              )
            ],
          ),
        ),
      );
    });

    test('with one dynamic bool property', () {
      final result = parser.parse('<Text visible={true}  />');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(
        result.value,
        equals(
          Node.tag(
            'Text',
            properties: [
              TagNodeProperty.member(
                'visible',
                Value.primitive(true),
              )
            ],
          ),
        ),
      );
    });

    test('with one dynamic object property', () {
      final result = parser.parse('<Text data={{ hello: "World", }}  />');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(
        result.value,
        equals(
          Node.tag(
            'Text',
            properties: [
              TagNodeProperty.member(
                'data',
                Value.object({'hello': Value.primitive('World')}),
              )
            ],
          ),
        ),
      );
    });

    test('with one aggregate', () {
      final result = parser.parse('<Text  {...props} />');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(
        result.value,
        equals(
          Node.tag(
            'Text',
            properties: [
              TagNodeProperty.aggregate('props'),
            ],
          ),
        ),
      );
    });
  });

  group('with children', () {
    test('without properties', () {
      final result =
          parser.parse('''<Text><Example /><Example2></Example2></Text>''');
      expect(result.isSuccess, isTrue, reason: result.reason());

      expect(
        result.value,
        equals(
          Node.tag(
            'Text',
            children: [
              Node.tag('Example'),
              Node.tag('Example2'),
            ],
          ),
        ),
      );
    });
  });
}
