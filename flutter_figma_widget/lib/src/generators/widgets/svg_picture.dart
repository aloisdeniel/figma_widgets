import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../dart.dart';

class SvgPictureGenerator extends DartGenerator<SvgPicture> {
  const SvgPictureGenerator();
  @override
  String toDart(SvgPicture value, BuildContext context) {
    final image = value.pictureProvider;
    final result = StringBuffer('');

    if (image is StringPicture) {
      result.write('SvgPicture.string(');
      result.write("r'''${image.string}''',");
    } else {
      result.write('SvgPicture(');
    }

    if (value.width != null) result.write("width: ${value.width},");
    if (value.height != null) result.write("height: ${value.height},");
    if (value.fit != BoxFit.contain) result.write("fit: ${value.fit},");

    result.write(")");
    return result.toString();
  }
}
