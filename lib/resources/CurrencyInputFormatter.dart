import 'package:qr_code_demo/config/numberformattter.dart';
import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print(oldValue);

    if (newValue != null && newValue.text.length > 0) {
      final String intStr = NumberFormatter.numberFormatter(
          double.tryParse(newValue.text.replaceAll(",", "") ?? 0));
      print(newValue);

      return TextEditingValue(
        text: intStr,
        selection: TextSelection.collapsed(offset: intStr.length),
      );
    } else {
      return TextEditingValue(
        text: "",
        selection: TextSelection.collapsed(offset: 0),
      );
    }
  }
}

// class CurrencyInputFormatter1 extends TextInputFormatter {

//     TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

//         if(newValue.selection.baseOffset == 0){
//             print(true);
//             return newValue;
//         }

//         double value = double.parse(newValue.text);

//         final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

//         String newText = formatter.format(value/100);

//         return newValue.copyWith(
//             text: newText,
//             selection: new TextSelection.collapsed(offset: newText.length));
//     }
// }
