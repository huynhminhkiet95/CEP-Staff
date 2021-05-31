import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
import 'package:flutter/material.dart';

class CustomDropdownLabel<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T> onChanged;
  final T value;
  final bool isEnabled;
  final double width;
  final bool isUnderline;
  CustomDropdownLabel(
      {Key key,
      @required this.dropdownMenuItemList,
      @required this.onChanged,
      @required this.value,
      @required this.width,
      this.isEnabled = true,
      @required this.isUnderline})
      : super(key: key);

  Decoration decorationUnderLine = BoxDecoration(
      border:
          Border(bottom: BorderSide(color: ColorConstants.cepColorBackground)),
      color: Colors.white);

  Decoration decorationForForm = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(
        color: ColorConstants.cepColorBackground,
        width: 1,
      ),
      color: Colors.white.withOpacity(0));
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        height: 38,
        width: width,
        padding:
            const EdgeInsets.only(left: 10.0, right: 10.0, top: 2, bottom: 2),
        decoration:
            isUnderline == true ? decorationUnderLine : decorationForForm,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            itemHeight: 50.0,
            style: TextStyle(
                color: isEnabled
                    ? ColorConstants.cepColorBackground
                    : Colors.grey[700]),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            value: value,
          ),
        ),
      ),
    );
  }
}
