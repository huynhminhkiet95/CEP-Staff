import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    var dateText = _addSeperators(newValue.text, '/');
    return newValue.copyWith(text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('/', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  static String regexDate(){
    var strRegex = r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$";
    return strRegex;
  }
  static String regexTime(){
    var strRegex = r"^(0[0-9]|1[0-9]|2[0-3]|[0-9]):[0-5][0-9]$";
    return strRegex;
  }

  static bool checkValidDate(String input){
    RegExp regExp = new RegExp(regexDate());
    return regExp.hasMatch(input);
  }
  static bool checkValidTime(String input){
    RegExp regExp = new RegExp(regexTime());
    return regExp.hasMatch(input);
  }
}