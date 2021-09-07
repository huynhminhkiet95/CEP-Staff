import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_state.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/ui/screens/Home/styles.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_bloc.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_event.dart';
import 'package:qr_code_demo/global_variables/global_download.dart';
import '../../../GlobalTranslations.dart';

class DownloadCommunityDevelopment extends StatefulWidget {
  DownloadCommunityDevelopment({Key key}) : super(key: key);

  @override
  _DownloadCommunityDevelopmentState createState() =>
      _DownloadCommunityDevelopmentState();
}

class _DownloadCommunityDevelopmentState
    extends State<DownloadCommunityDevelopment> {
  double screenWidth, screenHeight;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  TextEditingController textAutoCompleteCumId =
      new TextEditingController(text: "");
  String txtCum = "";

  DateTime selectedDate = DateTime.now();

  DownloadDataBloc downloadDataBloc;
  Services services;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //       _textDateEditingController.text =
  //           FormatDateConstants.convertDateTimeToString(selectedDate);
  //     });
  // }

  @override
  void initState() {
    services = Services.of(context);
    downloadDataBloc = new DownloadDataBloc(
        services.sharePreferenceService, services.commonService);
    super.initState();
  }

  void _onSubmit() {
    if (textAutoCompleteCumId.text.length > 0) {
      downloadDataBloc.emitEvent(
          DownloadDataCommunityDevelopmentEvent(textAutoCompleteCumId.text));
      GlobalDownload.isSubmitDownload = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return BlocEventStateBuilder<DownloadDataState>(
        bloc: downloadDataBloc,
        builder: (BuildContext context, DownloadDataState state) {
          return ModalProgressHUDCustomize(
            inAsyncCall: state?.isLoading ?? false,
            child: Container(
              color: Colors.blue,
              child: customScrollViewSliverAppBarForDownload(
                  allTranslations.text("DownloadCummunityDevelopment"),
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
                                      width: 90,
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
                                  width: 150,
                                  child: Center(
                                    child: SimpleAutoCompleteTextField(
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                        key: key,
                                        suggestions: [
                                          "B147",
                                          "B148",
                                          "B175",
                                          "B067",
                                        ],
                                        decoration: decorationTextFieldCEP,
                                        controller: textAutoCompleteCumId,
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
                              // Container(
                              //   height: 200,
                              //   width: 200,
                              //   child: Image.network(
                              //     'https://customer-api.cep.org.vn/File/Images/Customers/2021/hai.jpeg',
                              //   ),
                              // ),
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
                                        allTranslations.text(
                                            "DownloadCummunityDevelopment"),
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: _onSubmit,
                                shape: const StadiumBorder(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                  context),
            ),
          );
        });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
