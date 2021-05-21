import 'dart:ui';

extension wrapColor on String {
  Color get color {
    var hexColor = this.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
