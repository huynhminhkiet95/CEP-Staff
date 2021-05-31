import 'package:qr_code_demo/blocs/delete_data/delete_data_bloc.dart';
import 'package:qr_code_demo/blocs/delete_data/delete_data_event.dart';
import 'package:qr_code_demo/blocs/delete_data/delete_data_state.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/models/survey/survey_result.dart';
import 'package:qr_code_demo/ui/components/CustomDialog.dart';
import 'package:qr_code_demo/ui/screens/Home/styles.dart';
import 'package:qr_code_demo/ui/screens/survey/style.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:qr_code_demo/ui/screens/survey/listofsurveymembers.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/models/download_data/survey_info.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';

import '../../../GlobalUser.dart';

class DeleteDataScreen extends StatefulWidget {
  @override
  _DeleteDataScreenState createState() => _DeleteDataScreenState();
}

class _DeleteDataScreenState extends State<DeleteDataScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<String> listItemCumIdForSurvey;
  List<String> listItemNgayXuatDSForSurvey;
  List<String> listItemNgayThuNoForSurvey;
  List<String> listItemCumIdForCommunityDevelopment;
  String dropdownCumIdValue;
  String dropdownNgayXuatDanhSachValue;
  String dropdownDeptDateValue;

  String dropdownCumIdValueForCommunityDevelopment;

  double screenWidth, screenHeight;

  DeleteDataBloc deleteDataBloc;
  Services services;
  List<CheckBoxSurvey> checkBoxSurvey = new List<CheckBoxSurvey>();
  List<CheckBoxCommunityDevelopment> checkBoxCommunityDevelopment =
      new List<CheckBoxCommunityDevelopment>();

  bool isCheckAll = false;
  bool isCheckAllCommunityDevelopment = false;
  List<KhachHang> listCommunityDevelopment;
  SurveyStream surveyStream;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    services = Services.of(context);
    deleteDataBloc = new DeleteDataBloc(
        services.sharePreferenceService, services.commonService);
    deleteDataBloc.emitEvent(LoadSurveyEvent());
    deleteDataBloc.emitEvent(LoadCommunityDevelopmentEvent());
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _onSubmit() {
    deleteDataBloc.emitEvent(DeleteSurveyEvent(checkBoxSurvey, context,
        dropdownCumIdValue, dropdownNgayXuatDanhSachValue));
    checkBoxSurvey = new List<CheckBoxSurvey>();
  }

  void _onSubmitDeleteCommunityDevelopment() {
    deleteDataBloc.emitEvent(DeleteCommunityDevelopmentEvent(
        checkBoxCommunityDevelopment, context, dropdownCumIdValue));
    checkBoxCommunityDevelopment = new List<CheckBoxCommunityDevelopment>();
  }

  void _onSearchSurvey(String cumId, String date) {
    deleteDataBloc.emitEvent(SearchSurveyEvent(cumId, date));
  }

  void _onSearchCommunityDevelopment(String cumId) {
    deleteDataBloc.emitEvent(SearchCommunityDevelopmentEvent(cumId));
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    Widget bodySurvey = Container(
        color: Colors.blue,
        child: BlocEventStateBuilder<DeleteDataState>(
          bloc: deleteDataBloc,
          builder: (BuildContext context, DeleteDataState state) {
            return StreamBuilder<SurveyStream>(
                stream: deleteDataBloc.getSurveyStream,
                builder: (BuildContext context,
                    AsyncSnapshot<SurveyStream> snapshot) {
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

                    dropdownCumIdValue = surveyStream.cumID;
                    dropdownNgayXuatDanhSachValue = surveyStream.ngayXuatDS;
                    listItemCumIdForSurvey = surveyStream.listHistorySearch
                        .map((e) => e.cumID)
                        .toSet()
                        .toList();

                    listItemNgayXuatDSForSurvey = surveyStream.listHistorySearch
                        .where((e) => e.cumID == dropdownCumIdValue)
                        .map((e) => e.ngayXuatDanhSach)
                        .toSet()
                        .toList();

                    return ModalProgressHUDCustomize(
                      inAsyncCall: state?.isLoading ?? false,
                      child: customScrollViewSliverAppBarForDownload(
                          "Thông Tin Khảo Sát",
                          <Widget>[
                            Container(
                                height: orientation == Orientation.portrait
                                    ? screenHeight * 0.17
                                    : screenHeight * 0.3,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Card(
                                              elevation: 4.0,
                                              child: Container(
                                                height: 30,
                                                width: 90,
                                                child: Center(
                                                  child: Text(
                                                    "Cụm ID (${listItemCumIdForSurvey.length})",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff9596ab)),
                                                  ),
                                                ),
                                              )),
                                          Card(
                                              elevation: 4.0,
                                              child: Container(
                                                height: 30,
                                                width: 90,
                                                child: Center(
                                                  child: DropdownButton<String>(
                                                    value: dropdownCumIdValue,
                                                    elevation: 16,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                    underline: Container(
                                                      height: 0,
                                                      color: Colors.blue,
                                                    ),
                                                    onChanged:
                                                        (String newValue) {
                                                      _onSearchSurvey(
                                                          newValue, null);
                                                    },
                                                    items: listItemCumIdForSurvey
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
                                          Card(
                                              elevation: 4.0,
                                              child: Container(
                                                height: 30,
                                                width: 150,
                                                child: Center(
                                                  child: Text(
                                                    "Ngày Xuất Danh Sách",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff9596ab)),
                                                  ),
                                                ),
                                              )),
                                          Card(
                                              elevation: 4.0,
                                              child: Container(
                                                height: 30,
                                                width: 100,
                                                child: Center(
                                                  child: DropdownButton<String>(
                                                    value:
                                                        dropdownNgayXuatDanhSachValue,
                                                    elevation: 16,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                        color: Colors.black),
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
                                                    items: listItemNgayXuatDSForSurvey
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
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: screenHeight * 0.566000,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AnimatedContainer(
                                        height: 40,
                                        decoration: decorationButtonAnimated(
                                            checkBoxSurvey
                                                        .where((e) =>
                                                            e.status == true)
                                                        .length >
                                                    0
                                                ? Colors.green
                                                : Colors.grey),
                                        // Define how long the animation should take.
                                        duration: Duration(milliseconds: 500),
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
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                  size: 19,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Xóa Dữ Liệu",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onPressed: () {
                                            if (checkBoxSurvey
                                                    .where(
                                                        (e) => e.status == true)
                                                    .length >
                                                0) {
                                              dialogCustomForCEP(
                                                  context,
                                                  "Bạn muốn xóa các mục Khảo Sát đã chọn?",
                                                  _onSubmit,
                                                  children: [],
                                                  width: screenWidth * 0.7);
                                            }
                                          },
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        height: 40,

                                        width: this.isCheckAll == false
                                            ? 160
                                            : 140,
                                        decoration: decorationButtonAnimated(
                                            Colors.green),
                                        // Define how long the animation should take.
                                        duration: Duration(milliseconds: 500),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeOut,
                                        child: RawMaterialButton(
                                          fillColor: Colors.green,
                                          splashColor: Colors.grey,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
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
                                                      ? "Chọn Tất Cả"
                                                      : "Bỏ Chọn",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: getItemListView(
                                            surveyStream.listSurvey)),
                                  )
                                ],
                              ),
                            ),
                          ],
                          context),
                    );
                  } else {
                    return ModalProgressHUDCustomize(
                        inAsyncCall: state?.isLoading, child: Container());
                  }
                });
          },
        ));

    Widget bodyDept = Container(
        color: Colors.blue,
        child: BlocEventStateBuilder<DeleteDataState>(
          bloc: deleteDataBloc,
          builder: (BuildContext context, DeleteDataState state) {
            return StreamBuilder<SurveyStream>(
                stream: deleteDataBloc.getSurveyStream,
                builder: (BuildContext context,
                    AsyncSnapshot<SurveyStream> snapshot) {
                  if (snapshot.data != null) {
                    return ModalProgressHUDCustomize(
                      inAsyncCall: state?.isLoadingSaveData ?? false,
                      child: customScrollViewSliverAppBarForDownload(
                          "Thông Tin Thu Nợ",
                          <Widget>[
                            Container(
                                height: orientation == Orientation.portrait
                                    ? screenHeight * 0.17
                                    : screenHeight * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft: Radius.elliptical(260, 100)),
                                  color: Colors.white,
                                ),
                                //color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 60, right: 60),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Card(
                                              elevation: 4.0,
                                              child: Container(
                                                height: 30,
                                                width: 150,
                                                child: Center(
                                                  child: Text(
                                                    "Ngày Thu Nợ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff9596ab)),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: screenHeight * 0.566000,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AnimatedContainer(
                                        height: 40,
                                        decoration: decorationButtonAnimated(
                                            checkBoxSurvey
                                                        .where((e) =>
                                                            e.status == true)
                                                        .length >
                                                    0
                                                ? Colors.grey
                                                : Colors.grey),
                                        // Define how long the animation should take.
                                        duration: Duration(milliseconds: 500),
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
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                  size: 19,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Xóa Dữ Liệu",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onPressed: () {},
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        height: 40,

                                        width: this.isCheckAll == false
                                            ? 150
                                            : 130,
                                        decoration: decorationButtonAnimated(
                                            Colors.green),
                                        // Define how long the animation should take.
                                        duration: Duration(milliseconds: 500),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeOut,
                                        child: RawMaterialButton(
                                          fillColor: Colors.green,
                                          splashColor: Colors.grey,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  false == false
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
                                                  false == false
                                                      ? "Chọn Tất Cả"
                                                      : "Bỏ Chọn",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onPressed: () {
                                            //  isCheckAll = !isCheckAll;
                                            // setState(() {
                                            //   if (isCheckAll) {
                                            //     for (var item
                                            //         in checkBoxSurvey) {
                                            //       item.status = true;
                                            //     }
                                            //   } else {
                                            //     for (var item
                                            //         in checkBoxSurvey) {
                                            //       item.status = false;
                                            //     }
                                            //   }
                                            // });
                                          },
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                          context),
                    );
                  } else {
                    return ModalProgressHUDCustomize(
                        inAsyncCall: state?.isLoading, child: Container());
                  }
                });
          },
        ));

    Widget bodysavingsale = Container(
        color: Colors.blue,
        child: BlocEventStateBuilder<DeleteDataState>(
          bloc: deleteDataBloc,
          builder: (BuildContext context, DeleteDataState state) {
            return StreamBuilder<SurveyStream>(
                stream: deleteDataBloc.getSurveyStream,
                builder: (BuildContext context,
                    AsyncSnapshot<SurveyStream> snapshot) {
                  if (snapshot.data != null) {
                    return ModalProgressHUDCustomize(
                      inAsyncCall: state?.isLoadingSaveData ?? false,
                      child: customScrollViewSliverAppBarForDownload(
                          "Tư Vấn Tiết Kiệm",
                          <Widget>[
                            Container(
                                height: orientation == Orientation.portrait
                                    ? screenHeight * 0.17
                                    : screenHeight * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft: Radius.elliptical(260, 100)),
                                  color: Colors.white,
                                ),
                                //color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: screenHeight * 0.566000,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AnimatedContainer(
                                        height: 40,
                                        decoration: decorationButtonAnimated(
                                            checkBoxSurvey
                                                        .where((e) =>
                                                            e.status == true)
                                                        .length >
                                                    0
                                                ? Colors.grey
                                                : Colors.grey),
                                        // Define how long the animation should take.
                                        duration: Duration(milliseconds: 500),
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
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                  size: 19,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Xóa Dữ Liệu",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onPressed: () {},
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        height: 40,

                                        width: this.isCheckAll == false
                                            ? 150
                                            : 130,
                                        decoration: decorationButtonAnimated(
                                            Colors.green),
                                        // Define how long the animation should take.
                                        duration: Duration(milliseconds: 500),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeOut,
                                        child: RawMaterialButton(
                                          fillColor: Colors.green,
                                          splashColor: Colors.grey,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  false == false
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
                                                  false == false
                                                      ? "Chọn Tất Cả"
                                                      : "Bỏ Chọn",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onPressed: () {},
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                          context),
                    );
                  } else {
                    return ModalProgressHUDCustomize(
                        inAsyncCall: state?.isLoading, child: Container());
                  }
                });
          },
        ));

    Widget bodyCommunityDevelopment = Container(
        color: Colors.blue,
        child: BlocEventStateBuilder<DeleteDataState>(
          bloc: deleteDataBloc,
          builder: (BuildContext context, DeleteDataState state) {
            return StreamBuilder<List<KhachHang>>(
                stream: deleteDataBloc.getCommunityDevelopmentStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<KhachHang>> snapshot) {
                  if (snapshot.data != null) {
                    if (dropdownCumIdValueForCommunityDevelopment !=
                        globalUser.getCumIdOfCommunityDevelopment) {
                      listCommunityDevelopment = snapshot.data;
                      animationController.reset();
                      this.isCheckAllCommunityDevelopment = false;
                      checkBoxCommunityDevelopment =
                          new List<CheckBoxCommunityDevelopment>();
                      for (var item in listCommunityDevelopment) {
                        var findIndex = checkBoxCommunityDevelopment
                            .indexWhere((e) => e.id == item.id);
                        if (findIndex == -1) {
                          var model = new CheckBoxCommunityDevelopment();
                          model.id = item.id;
                          model.status = false;
                          checkBoxCommunityDevelopment.add(model);
                        }
                      }
                    } else {
                      listCommunityDevelopment = snapshot.data;
                      for (var item in listCommunityDevelopment) {
                        var findIndex = checkBoxCommunityDevelopment
                            .indexWhere((e) => e.id == item.id);
                        if (findIndex == -1) {
                          var model = new CheckBoxCommunityDevelopment();
                          model.id = item.id;
                          model.status = false;
                          checkBoxCommunityDevelopment.add(model);
                        }
                      }
                    }
                    dropdownCumIdValueForCommunityDevelopment =
                        globalUser.getCumIdOfCommunityDevelopment;
                    return ModalProgressHUDCustomize(
                      inAsyncCall: state?.isLoading ?? false,
                      child: customScrollViewSliverAppBarForDownload(
                          "Phát Triển Cộng Đồng",
                          <Widget>[
                            Container(
                                height: orientation == Orientation.portrait
                                    ? screenHeight * 0.17
                                    : screenHeight * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft: Radius.elliptical(260, 100)),
                                  color: Colors.white,
                                ),
                                //color: Colors.white,
                                child: StreamBuilder<List<String>>(
                                    stream: deleteDataBloc
                                        .getListTeamIDCommunityDevelopmentStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        listItemCumIdForCommunityDevelopment =
                                            snapshot.data;
                                        int indexOfItem =
                                            listItemCumIdForCommunityDevelopment
                                                .indexOf(globalUser
                                                    .getCumIdOfCommunityDevelopment);
                                        if (indexOfItem == -1) {
                                          dropdownCumIdValueForCommunityDevelopment =
                                              listItemCumIdForCommunityDevelopment
                                                          .length >
                                                      0
                                                  ? listItemCumIdForCommunityDevelopment
                                                      .first
                                                  : "";
                                          globalUser
                                                  .setCumIdOfCommunityDevelopment =
                                              dropdownCumIdValueForCommunityDevelopment;
                                        }

                                        return Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * 0.1,
                                                  right: screenWidth * 0.1),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Card(
                                                      elevation: 4.0,
                                                      child: Container(
                                                        height: 30,
                                                        width: 90,
                                                        child: Center(
                                                          child: Text(
                                                            "Cụm ID (${listItemCumIdForCommunityDevelopment.length})",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xff9596ab)),
                                                          ),
                                                        ),
                                                      )),
                                                  Card(
                                                      elevation: 4.0,
                                                      child: Container(
                                                        height: 30,
                                                        width: 90,
                                                        child: Center(
                                                          child: DropdownButton<
                                                              String>(
                                                            value:
                                                                dropdownCumIdValueForCommunityDevelopment,
                                                            elevation: 16,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                            underline:
                                                                Container(
                                                              height: 0,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            onChanged: (String
                                                                newValue) {
                                                              _onSearchCommunityDevelopment(
                                                                  newValue);
                                                            },
                                                            items: listItemCumIdForCommunityDevelopment.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    })),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: screenHeight * 0.566000,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AnimatedContainer(
                                        height: 40,
                                        decoration: decorationButtonAnimated(
                                            checkBoxCommunityDevelopment
                                                        .where((e) =>
                                                            e.status == true)
                                                        .length >
                                                    0
                                                ? Colors.green
                                                : Colors.grey),
                                        // Define how long the animation should take.
                                        duration: Duration(milliseconds: 500),
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
                                              mainAxisSize: MainAxisSize.min,
                                              children: const <Widget>[
                                                Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                  size: 19,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Xóa Dữ Liệu",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onPressed: () {
                                            if (checkBoxCommunityDevelopment
                                                    .where(
                                                        (e) => e.status == true)
                                                    .length >
                                                0) {
                                              dialogCustomForCEP(
                                                  context,
                                                  "Bạn muốn xóa các mục PTCĐ đã chọn?",
                                                  _onSubmitDeleteCommunityDevelopment,
                                                  children: [],
                                                  width: screenWidth * 0.7);
                                            }
                                          },
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        height: 40,

                                        width:
                                            this.isCheckAllCommunityDevelopment ==
                                                    false
                                                ? 150
                                                : 130,
                                        decoration: decorationButtonAnimated(
                                            Colors.green),
                                        // Define how long the animation should take.
                                        duration: Duration(milliseconds: 500),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.easeOut,
                                        child: RawMaterialButton(
                                          fillColor: Colors.green,
                                          splashColor: Colors.grey,
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  isCheckAllCommunityDevelopment ==
                                                          false
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
                                                  isCheckAllCommunityDevelopment ==
                                                          false
                                                      ? "Chọn Tất Cả"
                                                      : "Bỏ Chọn",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onPressed: () {
                                            isCheckAllCommunityDevelopment =
                                                !isCheckAllCommunityDevelopment;
                                            setState(() {
                                              if (isCheckAllCommunityDevelopment) {
                                                for (var item
                                                    in checkBoxCommunityDevelopment) {
                                                  item.status = true;
                                                }
                                              } else {
                                                for (var item
                                                    in checkBoxCommunityDevelopment) {
                                                  item.status = false;
                                                }
                                              }
                                            });
                                          },
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child:
                                            getItemListViewCommunityDevelopment(
                                                listCommunityDevelopment)),
                                  )
                                ],
                              ),
                            ),
                          ],
                          context),
                    );
                  } else {
                    return ModalProgressHUDCustomize(
                        inAsyncCall: state?.isLoading, child: Container());
                  }
                });
          },
        ));

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
          title: const Text(
            'Xóa Dữ Liệu',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          bottom: PreferredSize(
              child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.indigo.shade200,
                  indicatorColor: Colors.red,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Column(
                        children: [
                          Center(
                            child: Icon(IconsCustomize.survey_icon),
                          ),
                          Center(
                              child: Text(
                            'Khảo Sát',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          Center(
                            child: Icon(IconsCustomize.thu_no),
                          ),
                          Center(
                              child: Text(
                            'Thu Nợ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          Center(
                            child: Icon(IconsCustomize.tu_van),
                          ),
                          Center(
                              child: Text(
                            'Tư Vấn Tiết Kiệm',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          Center(
                            child: Icon(IconsCustomize.phattriencongdong),
                          ),
                          Center(
                              child: Text(
                            'PTCĐ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
                  ]),
              preferredSize: Size.fromHeight(30.0)),
        ),
        body: GestureDetector(
            onHorizontalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dx > sensitivity) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
                child: new TabBarView(
              children: [
                bodySurvey,
                bodyDept,
                bodysavingsale,
                bodyCommunityDevelopment
              ],
            ))),
      ),
    );
  }

  Widget getItemListView(List<SurveyInfo> listSurvey) {
    int count = listSurvey != null ? listSurvey.length : 0;
    return Container(
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: count,
        itemBuilder: (context, i) {
          final int count = listSurvey.length;
          final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
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
                        50 * (1.0 - animation.value), 0.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          this.checkBoxSurvey[i].status =
                              !this.checkBoxSurvey[i].status;
                          int totalCheck = this
                              .checkBoxSurvey
                              .where((e) => e.status == true)
                              .length;
                          if (totalCheck == this.checkBoxSurvey.length) {
                            this.isCheckAll = true;
                          } else {
                            this.isCheckAll = false;
                          }
                        });
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        color: Colors.white,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                              Container(
                                width: 290,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        "${listSurvey[i].thanhvienId} - ${listSurvey[i].hoVaTen}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  listSurvey[i].gioiTinh == 0
                                                      ? "Nữ"
                                                      : "Nam",
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
                                                listSurvey[i]
                                                    .ngaySinh
                                                    .substring(0, 4),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 4),
                                          child: Row(
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
                                                listSurvey[i].cmnd,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.blue,
                                          ),
                                          VerticalDivider(
                                            width: 1,
                                          ),
                                          Container(
                                            width: 230,
                                            child: Text(
                                              listSurvey[i].diaChi,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  Widget getItemListViewCommunityDevelopment(
      List<KhachHang> listCommunityDevelopment) {
    int count =
        listCommunityDevelopment != null ? listCommunityDevelopment.length : 0;
    return Container(
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: count,
        itemBuilder: (context, i) {
          final int count = listCommunityDevelopment.length;
          final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
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
                        50 * (1.0 - animation.value), 0.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          this.checkBoxCommunityDevelopment[i].status =
                              !this.checkBoxCommunityDevelopment[i].status;
                          int totalCheck = this
                              .checkBoxCommunityDevelopment
                              .where((e) => e.status == true)
                              .length;
                          if (totalCheck ==
                              this.checkBoxCommunityDevelopment.length) {
                            this.isCheckAllCommunityDevelopment = true;
                          } else {
                            this.isCheckAllCommunityDevelopment = false;
                          }
                        });
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        color: Colors.white,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.blue,
                                value: checkBoxCommunityDevelopment[i].status,
                                onChanged: (bool value) {
                                  setState(() {
                                    this
                                        .checkBoxCommunityDevelopment[i]
                                        .status = value;
                                    int totalCheck = this
                                        .checkBoxCommunityDevelopment
                                        .where((e) => e.status == true)
                                        .length;
                                    if (totalCheck ==
                                        this
                                            .checkBoxCommunityDevelopment
                                            .length) {
                                      this.isCheckAllCommunityDevelopment =
                                          true;
                                    } else {
                                      this.isCheckAllCommunityDevelopment =
                                          false;
                                    }
                                  });
                                },
                              ),
                              Container(
                                width: 290,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        "${listCommunityDevelopment[i].thanhVienId} - ${listCommunityDevelopment[i].hoTen}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  listCommunityDevelopment[i]
                                                              .gioitinh ==
                                                          0
                                                      ? "Nữ"
                                                      : "Nam",
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
                                                listCommunityDevelopment[i]
                                                    .ngaysinh
                                                    .substring(0, 4),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 4),
                                          child: Row(
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
                                                listCommunityDevelopment[i]
                                                    .cmnd,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.blue,
                                          ),
                                          VerticalDivider(
                                            width: 1,
                                          ),
                                          Container(
                                            width: 230,
                                            child: Text(
                                              listCommunityDevelopment[i]
                                                  .diachi,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
