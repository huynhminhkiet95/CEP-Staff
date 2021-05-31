import 'package:flutter/services.dart';
import 'package:qr_code_demo/config/numberformattter.dart';

class QuantityInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print(oldValue);

    if (newValue != null) {
      final String intStr = NumberFormatter.numberFormatter(
          double.tryParse(newValue.text.replaceAll(",", "") ?? 0));
      print(newValue);

      return TextEditingValue(
        text: intStr,
        selection: TextSelection.collapsed(offset: intStr.length),
      );
    } else {
      return TextEditingValue(
        text: "0",
        selection: TextSelection.collapsed(offset: 0),
      );
    }
  }
}
