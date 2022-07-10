import 'package:flutter/widgets.dart';
import '../dart.dart';

class ImageGenerator extends DartGenerator<Image> {
  const ImageGenerator();
  @override
  String toDart(Image value, BuildContext context) {
    final image = value.image;
    final result = StringBuffer('');

    if (image is NetworkImage) {
      result.write('Image.network(');
      result.write("'${image.url}',");
    }

    if (value.width != null) result.write("width: ${value.width},");
    if (value.height != null) result.write("height: ${value.height},");

    result.write(")");
    return result.toString();
  }
}
