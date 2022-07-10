import 'package:flutter/material.dart';
import 'package:flutter_figma_widget/flutter_figma_widget.dart';

class Preview extends StatelessWidget {
  const Preview({
    super.key,
    required this.result,
  });

  final Result<Component>? result;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: () {
          final result = this.result;
          if (result == null) {
            return const SizedBox();
          }

          if (result.isFailure) {
            return const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            );
          }

          return FigmaComponent(
            component: result.value,
          );
        }(),
      ),
    );
  }
}
