import 'package:flutter/material.dart';
import 'package:flutter_figma_widget/flutter_figma_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Figma Widget',
      home: Scaffold(
        body: Center(
          child: FigmaComponent.fromSource('''function Example() {
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
}'''),
        ),
      ),
    );
  }
}
