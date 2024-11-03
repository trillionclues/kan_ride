
import 'package:flutter/material.dart';

import './hex_color.dart';

class AppColor {
  AppColor._();

  ///light
  static Color primaryColor = HexColor("#0263F1");
  static Color primaryLightColor = HexColor("#EFF6FF");
  static Color textColor = Colors.black;
  static Color secondTextColor = Colors.black;
  static Color buttonHoverColor = HexColor("#0055CC");
  static Color buttonPressedColor = HexColor("#0044A3");
  static Color disabledColor = Colors.grey;
  static Color errorColor = HexColor("#E03737");
  static Color successColor = HexColor("##34B86C");
  static Color bg = HexColor("#FAFCFF");

  static List<Color> colors = [
    primaryColor,
    Colors.indigo,
    Colors.blue,
    Colors.redAccent,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.blueAccent,
    Colors.grey,
    Colors.green,
    Colors.teal,
  ];

}
