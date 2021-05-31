import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecorationTextFieldCEP(String hintText,
    {String suffixText = '', bool isCounterText = false}) {
  if (isCounterText) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(left: 10),
        labelStyle:
            TextStyle(fontSize: 11, color: ColorConstants.cepColorBackground),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.black26),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.cepColorBackground),
        ),
        suffixText: suffixText);
  } else {
    return InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.only(left: 10),
        labelStyle:
            TextStyle(fontSize: 11, color: ColorConstants.cepColorBackground),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.black26),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.cepColorBackground),
        ),
        suffixText: suffixText);
  }
}

TextStyle textStyleTextFieldCEP =
    TextStyle(color: ColorConstants.cepColorBackground, fontSize: 14);

Decoration decorationButtonAnimated(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(40),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 1), // changes position of shadow
      ),
    ],
  );
}

List<DropdownMenuItem<String>> _buildDropdown(
    List<ComboboxModel> listCombobox) {
  List<DropdownMenuItem<String>> items = List();
  items.add(DropdownMenuItem(
    value: '0',
    child: Text('Chọn'),
  ));

  for (var item in listCombobox) {
    items.add(DropdownMenuItem(
      value: item.itemId,
      child: Text(item.itemText),
    ));
  }
  return items;
}
