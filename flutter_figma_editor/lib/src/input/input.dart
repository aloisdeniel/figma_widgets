import 'package:flutter/material.dart';
import 'package:flutter_figma_widget/flutter_figma_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'formatted_spans.dart';

class InputEditor extends StatefulWidget {
  const InputEditor({
    super.key,
    this.initialSource = defaultInitialSource,
    required this.onResult,
  });

  static const defaultInitialSource = '''function Example() {
  return (
    <Text
      name="HelloWorld"
      fill="#3704C8"
      verticalAlignText="center"
      fontFamily="Inter"
      fontSize={46}
      fontWeight={700}
    >
      Hello World
    </Text>
  );
}''';

  final String initialSource;

  final ValueChanged<Result<Component>> onResult;

  @override
  State<InputEditor> createState() => _InputEditorState();
}

class _InputEditorState extends State<InputEditor> {
  late final controller = SourceEditingController(text: widget.initialSource);

  @override
  void initState() {
    controller.addListener(() {
      _compile();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _compile();
    });
    super.initState();
  }

  void _compile() {
    if (mounted) {
      final result = parseFigmaWidget(controller.text);
      widget.onResult(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff0f0f0),
      child: TextField(
        controller: controller,
        maxLines: null,
        style: GoogleFonts.firaCode(),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }
}

class SourceEditingController extends TextEditingController {
  SourceEditingController({
    super.text,
  });

  static final tokenStyles = <FormattedTokenType, TextStyle>{
    FormattedTokenType.methodName: const TextStyle(color: Color(0xFF000000)),
    FormattedTokenType.tag: const TextStyle(color: Color(0xFF000000)),
    FormattedTokenType.doubleLiteral: const TextStyle(color: Color(0xFF005cc5)),
    FormattedTokenType.stringLiteral: const TextStyle(color: Color(0xFFE66401)),
    FormattedTokenType.objectKey: const TextStyle(color: Color(0xFF005cc5)),
    FormattedTokenType.keyword: const TextStyle(color: Color(0xFFd73a49)),
  };

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final formatted = formatFigmaWidgetSource(value.text);

    return TextSpan(
      style: style,
      children: [
        buildFormattedSourceSpans(
          formatted: formatted,
          styles: tokenStyles,
          errorRegularStyle: const TextStyle(
            color: Colors.red,
          ),
          errorHighlightStyle: const TextStyle(
            color: Colors.white,
            backgroundColor: Colors.red,
          ),
        )
      ],
    );
  }
}
