import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/formatdate.dart';
import 'package:qr_code_demo/ui/screens/Home/styles.dart';

import '../../../GlobalTranslations.dart';

class DownloadDept extends StatefulWidget {
  DownloadDept({Key key}) : super(key: key);

  @override
  _DownloadDeptState createState() => _DownloadDeptState();
}

class _DownloadDeptState extends State<DownloadDept> {
  double screenWidth, screenHeight;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  TextEditingController textAutoComplete = new TextEditingController(text: "");
  String txtCum = "";
  TextEditingController _textDateEditingController = TextEditingController(
      text: FormatDateConstants.convertDateTimeToString(DateTime.now()));
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _textDateEditingController.text =
            FormatDateConstants.convertDateTimeToString(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Container(
      color: Colors.blue,
      child: customScrollViewSliverAppBarForDownload(
          allTranslations.text("DownloadDeptInfo"),
          <Widget>[
            Container(
              height: orientation == Orientation.portrait
                  ? size.height * 0.17
                  : size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                    bottomLeft: Radius.elliptical(260, 100)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.1, right: screenWidth * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                            elevation: 4.0,
                            child: Container(
                              height: 30,
                              width: 150,
                              child: Center(
                                child: Text(
                                  allTranslations.text("DeptDate"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xff9596ab)),
                                ),
                              ),
                            )),
                        Container(
                          height: 35,
                          width: size.width * 0.36,
                          child: InkWell(
                            child: Container(
                              width: screenWidth * 1,
                              height: 40,
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.blue)),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDate != null
                                        ? "${selectedDate.toLocal()}"
                                            .split(' ')[0]
                                        : "",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.blue),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    size: 17,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                            onTap: () => _selectDate(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: orientation == Orientation.portrait
                  ? screenHeight * 0.4
                  : screenHeight * 0.154,
              child: Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: RawMaterialButton(
                    fillColor: Colors.green,
                    splashColor: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.system_update,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            allTranslations.text("DownloadDeptInfo"),
                            maxLines: 1,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            )
          ],
          context),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
