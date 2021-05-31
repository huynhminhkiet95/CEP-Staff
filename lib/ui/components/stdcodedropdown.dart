import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/models/common/StdCode.dart';

typedef void SelectValueCallBack(String foo);

class StdCodeDropDown extends StatelessWidget {
  final String title;
  final List<StdCode> stdcodes;
  final String defaultValue;
  final SelectValueCallBack selectValueCallBack;
  const StdCodeDropDown(
      {Key key,
      this.stdcodes,
      this.title,
      this.defaultValue,
      this.selectValueCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.yellowColor,
                    fontStyle: FontStyle.normal),
              ),
            ),
            new Expanded(
              flex: 5,
              child: DropdownButton<String>(
                isExpanded: true,
                value: stdcodes.length > 0 ? defaultValue : "",
                onChanged: (String newValue) async {
                  selectValueCallBack(newValue);
                },
                items: stdcodes.map<DropdownMenuItem<String>>((StdCode value) {
                  return new DropdownMenuItem<String>(
                    value: value.codeId,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        value.codeDesc,
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
