import 'package:flutter/widgets.dart';

class FigmaText extends StatelessWidget {
  const FigmaText(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
