import 'package:figma_widget_parser/figma_widget_parser.dart';

import 'package:petitparser/reflection.dart';
import 'package:test/test.dart';

final definition = FigmaWidgetParserDefinition();
final parser = definition.build(start: definition.component);

extension ResultExt on Result {
  String reason() => isFailure ? '$message at $position' : '';
}

void main() {
  test('linter', () {
    expect(linter(parser), isEmpty);
  });

  test('simple', () {
    final result = parser.parse('''
function Example() {
  return (<Text />);
}
''');
    expect(result.isSuccess, isTrue, reason: result.reason());

    expect(
      result.value,
      equals(
        Component(
          name: 'Example',
          tree: TagNode('Text'),
        ),
      ),
    );
  });
}
