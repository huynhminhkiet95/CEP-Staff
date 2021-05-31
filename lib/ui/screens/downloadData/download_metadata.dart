import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_bloc.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_event.dart';
import 'package:qr_code_demo/blocs/download_data/download_data_state.dart';
import 'package:qr_code_demo/global_variables/global_download.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/ui/screens/Home/styles.dart';

import '../../../GlobalTranslations.dart';

class DownloadMetaData extends StatefulWidget {
  DownloadMetaData({Key key}) : super(key: key);

  @override
  _DownloadMetaDataState createState() => _DownloadMetaDataState();
}

class _DownloadMetaDataState extends State<DownloadMetaData> {
  double screenWidth, screenHeight;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  TextEditingController textAutoComplete = new TextEditingController(text: "");
  String txtCum = "";

  DateTime selectedDate = DateTime.now();
  DownloadDataBloc downloadDataBloc;
  Services services;

  @override
  void initState() {
    services = Services.of(context);
    downloadDataBloc = new DownloadDataBloc(
        services.sharePreferenceService, services.commonService);
    super.initState();
  }

  void _onSubmit() {
    downloadDataBloc.emitEvent(DownloadDataComboBoxEvent());
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
                  allTranslations.text("DownloadCombobox"),
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
                        children: [],
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
                                    allTranslations.text("DownloadCombobox"),
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
