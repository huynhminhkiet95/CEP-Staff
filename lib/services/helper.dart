import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/models/common/metadata_checkbox.dart';

class Helper {
  static List<DropdownMenuItem<String>> buildDropdownFromMetaData(
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

  static List<DropdownMenuItem<String>> buildDropdownNonMetaData(
      List<dynamic> list) {
    List<DropdownMenuItem<String>> items = List();
    items.add(DropdownMenuItem(
      value: '0',
      child: Text('Chọn'),
    ));

    for (var item in list) {
      items.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    }
    return items;
  }

  static bool checkFlag(int sum, int value) {
    bool rs = (sum & value) != 0;
    return rs;
  }

  static double sumValueCheckedForListCheckbox(List<MetaDataCheckbox> list) {
    double rs = 0;
    if (list
            .where((e) => e.value == true)
            .map((e) => e.itemID)
            .toList()
            .length >
        0) {
      rs = list
          .where((e) => e.value == true)
          .map((e) => e.itemID)
          .reduce((value, element) => value + element)
          .toDouble();
    }

    return rs;
  }
}
