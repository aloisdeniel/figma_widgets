import 'package:flutter/material.dart';
import 'package:flutter_figma_editor/src/output.dart';
import 'package:flutter_figma_widget/flutter_figma_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/input/input.dart';
import 'src/preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Figma Widget',
      home: Scaffold(
        body: Editor(),
      ),
    );
  }
}

class Editor extends StatefulWidget {
  const Editor({
    super.key,
  });

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  Result<Component>? result;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: InputEditor(
            onResult: (value) => setState(
              () => result = value,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Preview(result: result),
              ),
              Expanded(
                child: OutputPanel(result: result),
              ),
            ],
          ),
        )
      ],
    );
  }
}
