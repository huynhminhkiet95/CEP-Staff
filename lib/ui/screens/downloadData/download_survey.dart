import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_event.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_state.dart';
import 'package:qr_code_demo/global_variables/global_download.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/formatdate.dart';
import 'package:qr_code_demo/ui/screens/Home/styles.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_bloc.dart';
import 'package:qr_code_demo/services/service.dart';

class DownloadSurvey extends StatefulWidget {
  DownloadSurvey({Key key}) : super(key: key);

  @override
  _DownloadSurveyState createState() => _DownloadSurveyState();
}

class _DownloadSurveyState extends State<DownloadSurvey> {
  double screenWidth, screenHeight;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  TextEditingController _textCumIDAutoComplete =
      new TextEditingController(text: "");
  String txtCum = "";
  TextEditingController _textDateEditingController = TextEditingController(
      text: FormatDateConstants.convertDateTimeToString(DateTime.now()));
  DateTime selectedDate = DateTime.now();
  DownloadDataBloc downloadDataBloc;
  Services services;
  GlobalKey<FormState> formkeyDownload = GlobalKey<FormState>();

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
  void initState() {
    services = Services.of(context);
    downloadDataBloc = new DownloadDataBloc(
        services.sharePreferenceService, services.commonService);
    super.initState();
  }

  void _onSubmit() {
    downloadDataBloc.emitEvent(DownloadDataSurveyEvent(
        chiNhanhID: globalUser.getUserInfo == null
            ? ''
            : globalUser.getUserInfo.chiNhanhID,
        //chiNhanhID: 4,
        cumID: _textCumIDAutoComplete.text.toString(),
        ngayxuatDS: _textDateEditingController.text.toString(),
        //masoql: globalUser.getUserInfo == null ? '' : globalUser.getUserInfo.masoql
        masoql: globalUser.getUserInfo.masoql.toString()));
    GlobalDownload.isSubmitDownload = true;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Container(
      color: Colors.blue,
      child: BlocEventStateBuilder<DownloadDataState>(
          bloc: downloadDataBloc,
          builder: (BuildContext context, DownloadDataState state) {
            return ModalProgressHUDCustomize(
              inAsyncCall: state.isLoading,
              child: customScrollViewSliverAppBarForDownload(
                  allTranslations.text("DownloadSurveyInfo"),
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
                                left: screenWidth * 0.1,
                                right: screenWidth * 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                    elevation: 4.0,
                                    child: Container(
                                      height: 30,
                                      width: size.width * 0.2,
                                      child: Center(
                                        child: Text(
                                          allTranslations.text("ClusterID"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff9596ab)),
                                        ),
                                      ),
                                    )),
                                Container(
                                  height: 30,
                                  width: size.width * 0.55,
                                  child: Center(
                                    child: SimpleAutoCompleteTextField(
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                        key: key,
                                        suggestions: [
                                          "B147",
                                          "B148",
                                          "B175",
                                          "B067"
                                        ],
                                        decoration: decorationTextFieldCEP,
                                        controller: _textCumIDAutoComplete,
                                        textSubmitted: (text) {
                                          txtCum = text;
                                        },
                                        clearOnSubmit: false),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.1,
                                right: screenWidth * 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                    elevation: 4.0,
                                    child: Container(
                                      height: 30,
                                      width: size.width * 0.4,
                                      child: Center(
                                        child: Text(
                                          allTranslations.text("ExportDate"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Color(0xff9596ab)),
                                        ),
                                      ),
                                    )),
                                InkWell(
                                  onTap: () => _selectDate(context),
                                  child: Container(
                                    width: size.width * 0.36,
                                    child: Container(
                                      width: screenWidth * 1,
                                      height: 40,
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.blue)),
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
                                                fontSize: 13,
                                                color: Colors.blue),
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
                          child: Column(
                            children: [
                              RawMaterialButton(
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
                                        allTranslations
                                            .text("DownloadSurveyInfo"),
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  _onSubmit();
                                },
                                shape: const StadiumBorder(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                  context),
            );
          }),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
