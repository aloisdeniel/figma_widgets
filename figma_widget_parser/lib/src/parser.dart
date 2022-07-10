import 'package:petitparser/petitparser.dart';

import 'tree/tree.dart';
import 'grammar.dart';

Result<Component> parseFigmaWidget(String input) {
  return _parser.parse(input).map((x) => x as Component);
}

final _parser = FigmaWidgetParserDefinition().build();

class FigmaWidgetParserDefinition extends FigmaWidgetGrammarDefinition {
  // Components ----------------------------------------------------------------

  @override
  Parser component() {
    return super.component().map(
          (value) => Component(
            name: value[1],
            tree: value[8],
          ),
        );
  }

  // Nodes ---------------------------------------------------------------------

  @override
  Parser tagNodeWithoutChildren() {
    return super.tagNodeWithoutChildren().map(
          (each) => TagNode(
            each[1],
            properties: <TagNodeProperty>[
              ...(each[2] ?? const <TagNodeProperty>[]),
            ],
          ),
        );
  }

  @override
  Parser tagNodeWithChildren() {
    return super.tagNodeWithChildren().map(
      (each) {
        final TagNode start = each[0];
        return TagNode(
          start.identifier,
          properties: start.properties,
          children: <Node>[
            ...(each[1] ?? const <Node>[]),
          ],
        );
      },
    );
  }

  @override
  Parser tagNodeStart() {
    return super.tagNodeStart().map(
          (each) => TagNode(
            each[1],
            properties: <TagNodeProperty>[
              ...(each[2] ?? const <TagNodeProperty>[]),
            ],
          ),
        );
  }

  @override
  Parser tagNodeProperties() {
    return super.tagNodeProperties().map((each) => each[1]);
  }

  @override
  Parser tagNodePropertyAggregate() {
    return super.tagNodePropertyAggregate().map((each) {
      final ReferenceValue reference = each[1];
      return TagNodeAggregateProperty(reference.name);
    });
  }

  @override
  Parser tagNodePropertyMember() {
    return super.tagNodePropertyMember().map(
          (each) => TagNodeMemberProperty(
            each[0],
            each[2],
          ),
        );
  }

  @override
  Parser tagNodeMemberDynamicValue() {
    return super.tagNodeMemberDynamicValue().map(
          (each) => each[1],
        );
  }

  @override
  Parser textNode() {
    return super.textNode().map((each) => TextNode(each.join()));
  }

  // Values --------------------------------------------------------------------

  @override
  Parser objectValue() => super.objectValue().map((each) {
        final result = <String, Value>{};
        if (each[1] != null) {
          for (final element in each[1]) {
            result[element[0]] = element[2];
          }
        }
        return Value.object(result);
      });

  @override
  Parser arrayValue() => super.arrayValue().map(
        (each) => Value.array(
          <Value>[
            ...(each[1] ?? const <Value>[]),
          ],
        ),
      );

  @override
  Parser trueValue() => super.trueValue().map((each) => Value.primitive(true));

  @override
  Parser falseValue() =>
      super.falseValue().map((each) => Value.primitive(false));

  @override
  Parser nullValue() => super.nullValue().map((each) => Value.primitive(null));

  @override
  Parser stringValue() =>
      ref0(stringPrimitive).trim().map((each) => Value.primitive(each));

  @override
  Parser numberValue() =>
      super.numberValue().map((each) => Value.primitive(num.parse(each)));

  @override
  Parser referenceValue() =>
      super.referenceValue().map((each) => Value.reference(each));

  @override
  Parser identifier() =>
      super.identifier().map((each) => each[0] + each[1].join());

  @override
  Parser stringPrimitive() =>
      super.stringPrimitive().map((each) => each[1].join());

  @override
  Parser characterEscape() =>
      super.characterEscape().map((each) => jsonEscapeChars[each[1]]);

  @override
  Parser characterUnicode() => super.characterUnicode().map((each) {
        final charCode = int.parse(each[1].join(), radix: 16);
        return String.fromCharCode(charCode);
      });
}
