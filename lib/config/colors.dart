import 'package:flutter/material.dart';

class ColorConstants {
  static String mainColor = "#ffc651";
  static String grayColor = "#b6b6b6";
  static Color yellowColor = Color.fromARGB(255, 255, 198, 81);
  static Color whiteColor = Color.fromARGB(255, 255, 155, 255);
  static String backgroud = '#169a5a';
  static Color backgroudButton = Color(getColorHexFromStr('009750'));
  static Color cepColorBackground = Color(0xff003399);
  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;

    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }
}
