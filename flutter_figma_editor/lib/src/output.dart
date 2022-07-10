import 'package:flutter/material.dart';
import 'package:flutter_figma_widget/flutter_figma_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class OutputPanel extends StatelessWidget {
  const OutputPanel({
    super.key,
    required this.result,
  });

  final Result<Component>? result;

  @override
  Widget build(BuildContext context) {
    final errorMessage = result.toErrorMessage();
    return Container(
      color: const Color(0xFF111111),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: () {
          if (errorMessage != null) {
            return Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            );
          }

          return SelectableText(
            const ComponentGenerator().toDart(result!.value, context),
            style: GoogleFonts.firaCode(
              fontSize: 11,
              color: Colors.white,
            ),
          );
        }(),
      ),
    );
  }
}

extension ResultExtension on Result? {
  String? toErrorMessage() {
    final result = this;

    if (result == null) {
      return 'Empty';
    }
    if (result.isFailure) {
      return 'Parsing failed: \n ${result.message} at ${result.position}';
    }
    return null;
  }
}
