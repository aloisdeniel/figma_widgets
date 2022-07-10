import 'package:flutter/material.dart';
import 'package:flutter_figma_widget/flutter_figma_widget.dart';

final _returnLineRegexp = RegExp(r'\n');

TextSpan buildFormattedSourceSpans({
  required Result<FormattedSource> formatted,
  required Map<FormattedTokenType, TextStyle> styles,
  required TextStyle errorRegularStyle,
  required TextStyle errorHighlightStyle,
}) {
  if (formatted.isSuccess) {
    return _buildSucceededFormattedSourceSpans(
      source: formatted.value,
      styles: styles,
    );
  }
  return _buildFailedSourceSpans(
    result: formatted,
    errorHighlightStyle: errorHighlightStyle,
    errorRegularStyle: errorRegularStyle,
  );
}

TextSpan _buildSucceededFormattedSourceSpans({
  required FormattedSource source,
  required Map<FormattedTokenType, TextStyle> styles,
}) {
  final spans = <TextSpan>[];
  var lastIndex = 0;
  for (var token in source.tokens) {
    if (lastIndex < token.token.start) {
      spans.add(
        TextSpan(
          text: source.source.substring(lastIndex, token.token.start),
        ),
      );
    }
    spans.add(
      TextSpan(
        text: token.token.input,
        style: styles[token.type],
      ),
    );
    lastIndex = token.token.stop;
  }

  if (lastIndex < source.source.length - 1) {
    spans.add(
      TextSpan(
        text: source.source.substring(lastIndex, source.source.length - 1),
      ),
    );
  }

  return TextSpan(children: spans);
}

TextSpan _buildFailedSourceSpans({
  required Result result,
  required TextStyle errorRegularStyle,
  required TextStyle errorHighlightStyle,
}) {
  final spans = <TextSpan>[];
  if (result.buffer.isNotEmpty) {
    if (result.position > 0) {
      spans.add(TextSpan(
        text: result.buffer.substring(0, result.position),
        style: errorRegularStyle,
      ));
    }
    if (result.position < result.buffer.length) {
      final remaining =
          result.buffer.substring(result.position, result.buffer.length);
      var returnLineIndexAfterPosition =
          _returnLineRegexp.firstMatch(remaining)?.start ?? result.position + 1;

      spans.add(
        TextSpan(
          text: remaining.substring(0, returnLineIndexAfterPosition),
          style: errorHighlightStyle,
        ),
      );
      if (returnLineIndexAfterPosition < remaining.length) {
        spans.add(TextSpan(
          text: remaining.substring(
              returnLineIndexAfterPosition, remaining.length),
          style: errorRegularStyle,
        ));
      }
    }
  }
  return TextSpan(children: spans);
}
