import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
import 'package:qr_code_demo/models/survey/survey_result.dart';
import 'package:qr_code_demo/ui/components/CustomDialog.dart';
import 'package:badges/badges.dart';
import 'package:qr_code_demo/ui/screens/survey/style.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:qr_code_demo/ui/screens/survey/listofsurveymembers.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/blocs/survey/survey_bloc.dart';
import 'package:qr_code_demo/blocs/survey/survey_event.dart';
import 'package:qr_code_demo/blocs/survey/survey_state.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/models/download_data/survey_info.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:qr_code_demo/config/map_utils.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  double opacity = 0.0;
  List<String> listItemCumId;
  List<String> listItemNgayXuatDS;
  String dropdownCumIdValue;
  String dropdownNgayXuatDanhSachValue;
  int selectedIndexKhuVuc;
  double screenWidth, screenHeight;

  SurveyBloc surVeyBloc;
  Services services;
  List<CheckBoxSurvey> checkBoxSurvey = new List<CheckBoxSurvey>();
  bool isCheckAll = false;

  SurveyStream surveyStream;
  List<String> listTypeArea = [
    allTranslations.text("All"),
    allTranslations.text("NotYetSurveyed"),
    allTranslations.text("Surveyed")
  ];
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    services = Services.of(context);
    surVeyBloc =
        new SurveyBloc(services.sharePreferenceService, services.commonService);
    surVeyBloc.emitEvent(LoadSurveyEvent());
    setData();
    super.initState();
    selectedIndexKhuVuc = 0;
  }

  Future<void> setData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity = 1.0;
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _onSubmit() {
    surVeyBloc.emitEvent(UpdateSurveyToServerEvent(checkBoxSurvey, context));
  }

  void _onSearchSurvey(String cumId, String date) {
    surVeyBloc.emitEvent(SearchSurveyEvent(cumId, date));
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    Widget body = BlocEventStateBuilder<SurveyState>(
      bloc: surVeyBloc,
      builder: (BuildContext context, SurveyState state) {
        return StreamBuilder<SurveyStream>(
            stream: surVeyBloc.getSurveyStream,
            builder:
                (BuildContext context, AsyncSnapshot<SurveyStream> snapshot) {
              if (snapshot.data != null) {
                surveyStream = snapshot.data;

                if (dropdownCumIdValue != surveyStream.cumID) {
                  animationController.reset();
                  this.isCheckAll = false;
                  checkBoxSurvey = new List<CheckBoxSurvey>();
                  for (var item in surveyStream.listSurvey) {
                    var findIndex =
                        checkBoxSurvey.indexWhere((e) => e.id == item.id);
                    if (findIndex == -1) {
                      var model = new CheckBoxSurvey();
                      model.id = item.id;
                      model.status = false;
                      checkBoxSurvey.add(model);
                    }
                  }
                } else {
                  //  animationController.reset();
                  if (surveyStream.listSurvey != null) {
                    for (var item in surveyStream.listSurvey) {
                      var findIndex =
                          checkBoxSurvey.indexWhere((e) => e.id == item.id);
                      if (findIndex == -1) {
                        var model = new CheckBoxSurvey();
                        model.id = item.id;
                        model.status = false;
                        checkBoxSurvey.add(model);
                      }
                    }
                  }
                }

                dropdownCumIdValue = surveyStream.cumID;
                dropdownNgayXuatDanhSachValue = surveyStream.ngayXuatDS;
                listItemCumId = surveyStream.listHistorySearch
                    .map((e) => e.cumID)
                    .toSet()
                    .toList();

                listItemNgayXuatDS = surveyStream.listHistorySearch
                    .where((e) => e.cumID == dropdownCumIdValue)
                    .map((e) => e.ngayXuatDanhSach)
                    .toSet()
                    .toList();

                return Container(
                  color: surveyStream.listSurvey != null
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  child: ModalProgressHUDCustomize(
                    inAsyncCall: state?.isLoadingSaveData ?? false,
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.07,
                          color: Theme.of(context).accentColor,
                          child: Center(
                            child: Text(
                              surveyStream.listSurvey != null
                                  ? allTranslations.text("ListSurveyMember")
                                  : "",
                              //  textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstants.cepColorBackground,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  wordSpacing: 5),
                            ),
                          ),
                        ),
                        Container(
                          height: orientation == Orientation.portrait
                              ? screenHeight * 0.17
                              : screenHeight * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.elliptical(260, 100)),
                            color: Theme.of(context).accentColor,
                          ),
                          child: surveyStream.listSurvey != null
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.1,
                                          right: screenWidth * 0.1),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            opacity: opacity,
                                            child: Card(
                                                elevation: 4.0,
                                                child: Container(
                                                  height: 30,
                                                  width: 90,
                                                  child: Center(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        "${allTranslations.text("ClusterID")} (${listItemCumId.length})",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xff9596ab)),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            opacity: opacity,
                                            child: Card(
                                                elevation: 4.0,
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight: 30,
                                                    maxWidth: double.infinity,
                                                  ),
                                                  child: Center(
                                                    child:
                                                        DropdownButton<String>(
                                                      value: dropdownCumIdValue,
                                                      elevation: 16,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .textSelectionHandleColor),
                                                      underline: Container(
                                                        height: 0,
                                                        color: Colors.blue,
                                                      ),
                                                      onChanged:
                                                          (String newValue) {
                                                        _onSearchSurvey(
                                                            newValue, null);
                                                      },
                                                      items: listItemCumId.map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                )),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            opacity: opacity,
                                            child: Card(
                                                elevation: 4.0,
                                                child: Container(
                                                  height: 30,
                                                  width: 150,
                                                  child: Center(
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        allTranslations
                                                            .text("ExportDate"),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xff9596ab)),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            opacity: opacity,
                                            child: Card(
                                                elevation: 4.0,
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight: 30,
                                                    maxWidth: double.infinity,
                                                  ),
                                                  child: Center(
                                                    child:
                                                        DropdownButton<String>(
                                                      value:
                                                          dropdownNgayXuatDanhSachValue,
                                                      elevation: 16,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .textSelectionHandleColor),
                                                      underline: Container(
                                                        height: 0,
                                                        color: Colors.blue,
                                                      ),
                                                      onChanged:
                                                          (String newValue) {
                                                        _onSearchSurvey(
                                                            dropdownCumIdValue,
                                                            newValue);
                                                      },
                                                      items: listItemNgayXuatDS
                                                          .map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                        Expanded(
                          child: Container(
                            color: surveyStream.listSurvey != null
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    surveyStream.listSurvey != null
                                        ? AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            opacity: opacity,
                                            child: AnimatedContainer(
                                              height: 40,
                                              width: this.isCheckAll == false
                                                  ? 140
                                                  : 160,
                                              decoration:
                                                  decorationButtonAnimated(
                                                      Colors.green),
                                              // Define how long the animation should take.
                                              duration:
                                                  Duration(milliseconds: 500),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeOut,
                                              child: RawMaterialButton(
                                                fillColor: Colors.green,
                                                splashColor: Colors.grey,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Icon(
                                                        this.isCheckAll == false
                                                            ? Icons
                                                                .check_box_outline_blank
                                                            : Icons.check_box,
                                                        color: Colors.white,
                                                        size: 19,
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        this.isCheckAll == false
                                                            ? allTranslations
                                                                .text(
                                                                    "SelectAll")
                                                            : allTranslations.text(
                                                                "UnSelectAll"),
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () {
                                                  isCheckAll = !isCheckAll;
                                                  setState(() {
                                                    if (isCheckAll) {
                                                      for (var item
                                                          in checkBoxSurvey) {
                                                        item.status = true;
                                                      }
                                                    } else {
                                                      for (var item
                                                          in checkBoxSurvey) {
                                                        item.status = false;
                                                      }
                                                    }
                                                  });
                                                },
                                                shape: const StadiumBorder(),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    surveyStream.listSurvey != null
                                        ? AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            opacity: opacity,
                                            child: AnimatedContainer(
                                              height: 40,
                                              decoration:
                                                  decorationButtonAnimated(
                                                      checkBoxSurvey
                                                                  .where((e) =>
                                                                      e.status ==
                                                                      true)
                                                                  .length >
                                                              0
                                                          ? Colors.green
                                                          : Colors.grey),
                                              // Define how long the animation should take.
                                              duration:
                                                  Duration(milliseconds: 500),
                                              // Provide an optional curve to make the animation feel smoother.
                                              curve: Curves.easeOut,
                                              child: RawMaterialButton(
                                                splashColor: Colors.green,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15,
                                                      top: 10,
                                                      left: 10,
                                                      bottom: 10),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.upload_rounded,
                                                        color: Colors.white,
                                                        size: 19,
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        allTranslations.text(
                                                            "UpdateToServer"),
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (checkBoxSurvey
                                                          .where((e) =>
                                                              e.status == true)
                                                          .length >
                                                      0) {
                                                    dialogCustomForCEP(
                                                        context,
                                                        allTranslations.text(
                                                            "ConfirmSaveDataToServer"),
                                                        _onSubmit,
                                                        children: [],
                                                        width:
                                                            screenWidth * 0.7);
                                                  }
                                                },
                                                shape: const StadiumBorder(),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Builder(builder: (context) {
                                  if (surveyStream.listSurvey != null) {
                                    int badgesAll,
                                        badgeNotSurvey,
                                        badgeSurveyed = 0;

                                    badgesAll = surveyStream.listSurvey.length;

                                    badgeSurveyed = surveyStream.listSurvey
                                        .where((e) =>
                                            e.ghiChu.length > 0 &&
                                            e.soTienDuyetChovay > 0)
                                        .toList()
                                        .length;

                                    badgeNotSurvey = surveyStream.listSurvey
                                        .where((e) =>
                                            e.ghiChu.length == 0 &&
                                            e.soTienDuyetChovay == 0)
                                        .toList()
                                        .length;

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        customRadio(
                                            listTypeArea[0], 0, badgesAll),
                                        VerticalDivider(
                                          width: 10,
                                        ),
                                        customRadio(
                                            listTypeArea[1], 1, badgeNotSurvey),
                                        VerticalDivider(
                                          width: 10,
                                        ),
                                        customRadio(
                                            listTypeArea[2], 2, badgeSurveyed),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: ModalProgressHUDCustomize(
                                        inAsyncCall: state?.isLoading ?? false,
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: surveyStream.listSurvey !=
                                                    null
                                                ? getItemListView(
                                                    surveyStream.listSurvey)
                                                : Container(
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                            'assets/images/no_data.gif',
                                                            width: 150,
                                                            height: 150),
                                                        Text(
                                                          allTranslations.text(
                                                              "NoDataFound"),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[700],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              wordSpacing: 1),
                                                        ),
                                                        Text(
                                                          allTranslations.text(
                                                              "ClickThisButtonToDownload"),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[700],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              wordSpacing: 1),
                                                        ),
                                                        RaisedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                'download',
                                                                arguments: {
                                                                  'selectedIndex':
                                                                      0,
                                                                }).then(
                                                                (value) =>
                                                                    setState(
                                                                        () {
                                                                      if (true ==
                                                                          value) {
                                                                        surVeyBloc
                                                                            .emitEvent(LoadSurveyEvent());
                                                                      }
                                                                    }));
                                                          },
                                                          child: Text(
                                                            allTranslations
                                                                .text(
                                                                    "DownLoad"),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          color: Colors.cyan,
                                                          textColor:
                                                              Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return ModalProgressHUDCustomize(
                    inAsyncCall: state?.isLoading, child: Container());
              }
            });
      },
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: ColorConstants.cepColorBackground,
        elevation: 20,
        title: Text(
          allTranslations.text("BorrowingCapitalSurvey"),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          // DropdownButton<String>(
          //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: new Text(value),
          //     );
          //   }).toList(),
          //   onChanged: (_) {},
          // ),
          // PopupMenuButton<String>(
          //   onSelected: handleClick,
          //   itemBuilder: (BuildContext context) {
          //     return {'Logout', 'Settings'}.map((String choice) {
          //       return PopupMenuItem<String>(
          //         value: choice,
          //         child: Text(choice),
          //       );
          //     }).toList();
          //   },
          // ),
          // IconButton(
          //     icon: Icon(
          //       Icons.filter_list,
          //       color: Colors.white,
          //       size: 20,
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     }),
          //   DropD
        ],
      ),
      body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) {
              Navigator.of(context).pop();
            }
          },
          child: Container(child: body)),
    );
  }

  Widget getItemListView(List<SurveyInfo> listSurvey) {
    List<SurveyInfo> finalListSurvey;
    if (selectedIndexKhuVuc == 0) {
      finalListSurvey = listSurvey;
    } else if (selectedIndexKhuVuc == 2) {
      finalListSurvey = listSurvey
          .where((e) => e.ghiChu.length > 0 && e.soTienDuyetChovay > 0)
          .toList();
    } else {
      finalListSurvey = listSurvey
          .where((e) => e.ghiChu.length == 0 && e.soTienDuyetChovay == 0)
          .toList();
    }

    int count = finalListSurvey != null ? finalListSurvey.length : 0;
    if (count == 0) {
      return Container(
        child: Center(
            child: Text(
          "Kh??ng c?? d??? li???u",
          style: TextStyle(color: Colors.white),
        )),
      );
    }
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: count,
      itemBuilder: (context, i) {
        final int count = finalListSurvey.length;
        final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(
                parent: animationController,
                curve: Interval((1 / count) * i, 1.0,
                    curve: Curves.fastOutSlowIn)));
        animationController.forward();

        return AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return FadeTransition(
                opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 50 * (1.0 - animation.value), 0.0),
                  child: InkWell(
                    onTap: () {
                      List<ComboboxModel> listCombobox =
                          globalUser.getListComboboxModel;
                      List<SurveyInfo> listSurveyDetail = finalListSurvey;
                      if (listCombobox == null || listCombobox.length == 0) {
                        Navigator.pushNamed(context, 'download', arguments: {
                          'selectedIndex': 4,
                        }).then((value) => setState(() {
                              if (true == value) {
                                initState();
                              }
                            }));
                      } else {
                        Navigator.pushNamed(context, 'surveydetail',
                            arguments: {
                              'id': finalListSurvey[i].id,
                              'metadata': listCombobox,
                              'surveydetail': listSurveyDetail[i],
                              'surveyhistory':
                                  surveyStream.listSurveyInfoHistory,
                            }).then((value) {
                          //String a = value;
                          if (value is List<SurveyInfo>) {
                            setState(() {
                              // listSurvey = value;
                              surVeyBloc.emitEvent(
                                  SearchSurveyEvent(dropdownCumIdValue, null));
                            });
                          }
                        });
                        // setState(() {
                        //       String a = value;
                        //    //   listSurvey = value;
                        //     }));
                      }
                    },
                    child: Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(13),
                      //   ),
                      //   color: Colors.blue,
                      // ),
                      // height: 130,
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        color: Theme.of(context).cardColor,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 8),
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.blue,
                                value: checkBoxSurvey[i].status,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkBoxSurvey[i].status = value;
                                    int totalCheck = this
                                        .checkBoxSurvey
                                        .where((e) => e.status == true)
                                        .length;
                                    if (totalCheck ==
                                        this.checkBoxSurvey.length) {
                                      this.isCheckAll = true;
                                    } else {
                                      this.isCheckAll = false;
                                    }
                                  });
                                },
                              ),
                              Expanded(
                                //     width: screenWidth * 0.82,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Builder(builder: (context) {
                                        Widget cardBatBuoc = Container();
                                        Widget cardkhaosat = Container();
                                        if (finalListSurvey[i].batBuocKhaosat ==
                                            1) {
                                          cardBatBuoc = Card(
                                              elevation: 3,
                                              color: Colors.red[900],
                                              child: Container(
                                                height: 20,
                                                width: 140,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    allTranslations
                                                        .text("Mandatory"),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ));
                                        }

                                        if (finalListSurvey[i].ghiChu.length >
                                                0 &&
                                            finalListSurvey[i]
                                                    .soTienDuyetChovay >
                                                0) {
                                          cardkhaosat = Card(
                                              elevation: 3,
                                              color: Colors.red,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: 5, left: 5),
                                                height: 20,
                                                width: 100,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    allTranslations
                                                        .text("Surveyed"),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ));
                                        } else {
                                          cardkhaosat = Card(
                                              elevation: 3,
                                              color: Colors.grey,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: 5, left: 5, top: 2),
                                                height: 20,
                                                width: 103,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    allTranslations
                                                        .text("NotYetSurveyed"),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ));
                                        }

                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            cardkhaosat,
                                            cardBatBuoc,
                                          ],
                                        );
                                      })),
                                      Container(
                                        padding: EdgeInsets.only(left: 4),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "${finalListSurvey[i].thanhvienId} - ${finalListSurvey[i].hoVaTen}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  IconsCustomize.gender,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                VerticalDivider(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 30,
                                                  child: Text(
                                                    finalListSurvey[i]
                                                                .gioiTinh ==
                                                            0
                                                        ? allTranslations
                                                            .text("FeMale")
                                                        : allTranslations
                                                            .text("Male"),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  IconsCustomize.birth_date,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                                VerticalDivider(
                                                  width: 10,
                                                ),
                                                VerticalDivider(
                                                  width: 1,
                                                ),
                                                Text(
                                                  finalListSurvey[i]
                                                      .ngaySinh
                                                      .substring(0, 4),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  IconsCustomize.id_card,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                VerticalDivider(
                                                  width: 15,
                                                ),
                                                Text(
                                                  finalListSurvey[i].cmnd,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.only(left: 6),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenWidth * 0.72,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.blue,
                                                  ),
                                                  VerticalDivider(
                                                    width: 1,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      finalListSurvey[i].diaChi,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    MapUtils.openMap(
                                                        finalListSurvey[i]
                                                            .diaChi);
                                                  },
                                                  child: Icon(
                                                    Icons.assistant_direction,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndexKhuVuc = index;
    });
  }

  Widget customRadio(String txt, int index, int badge) {
    return OutlineButton(
      onPressed: () => changeIndex(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      borderSide: BorderSide(
          color: selectedIndexKhuVuc == index
              ? Colors.grey[100]
              : ColorConstants.cepColorBackground.withOpacity(0)),
      child: Row(
        children: [
          Text(
            txt,
            style: TextStyle(
                color: selectedIndexKhuVuc == index
                    ? Colors.grey[100]
                    : Colors.grey[300],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 4,
          ),
          Badge(
            badgeColor: Colors.grey,
            borderRadius: BorderRadius.circular(5),
            position: BadgePosition.topEnd(top: 1, end: 10),
            alignment: Alignment.topRight,
            animationDuration: Duration(milliseconds: 1000),
            animationType: BadgeAnimationType.scale,
            badgeContent: Text(
              badge.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
            // position: BadgePosition.topEnd(top: 0, end: 0),
          )
        ],
      ),
    );
  }
}
