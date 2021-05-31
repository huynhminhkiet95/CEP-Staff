import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class TimeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }
    if(newValue.text.length  == 2 && int.parse(newValue.text) > 24){
      var dateText = _addSeperators('24', ':');
      return newValue.copyWith(text: dateText, selection: updateCursorPosition(dateText));
    }
    if(newValue.text.length  == 5 && int.parse(newValue.text.substring(3,5)) > 59){
       var subtime = newValue.text.substring(0,3);
       var dateText = _addSeperators(subtime + '59', ':');
      return newValue.copyWith(text: dateText, selection: updateCursorPosition(dateText));
    }
    var dateText = _addSeperators(newValue.text, ':');
    return newValue.copyWith(text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll(':', '');
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
}