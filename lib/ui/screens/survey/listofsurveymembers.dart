import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/blocs/survey/survey_bloc.dart';
import 'package:qr_code_demo/blocs/survey/survey_event.dart';
import 'package:qr_code_demo/blocs/survey/survey_state.dart';
import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/models/download_data/survey_info.dart';

class ListOfSurveyMembers extends StatefulWidget {
  ListOfSurveyMembers({Key key}) : super(key: key);

  @override
  _ListOfSurveyMembersState createState() => _ListOfSurveyMembersState();
}

class _ListOfSurveyMembersState extends State<ListOfSurveyMembers> {
  double screenWidth, screenHeight;
  List<CheckBoxSurvey> checkBoxSurvey = new List<CheckBoxSurvey>();
  SurveyBloc surVeyBloc;
  Services services;

  Widget getItemListView(List<SurveyInfo> listSurvey) {
    for (var item in listSurvey) {
      var model = new CheckBoxSurvey();
      model.id = item.id;
      model.status = false;
      checkBoxSurvey.add(model);
    }

    int count = listSurvey != null ? listSurvey.length : 0;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            ),
            color: Colors.blue,
          ),
          height: 130,
          child: Card(
            elevation: 4,
            shadowColor: Colors.blue,
            color: Colors.white,
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
                      });
                    },
                  ),
                  Container(
                    width: 290,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                                elevation: 3,
                                color: Colors.red,
                                child: Container(
                                  height: 20,
                                  width: 80,
                                  child: Text(
                                    "Đã Khảo Sát",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                )),
                            Card(
                                elevation: 3,
                                color: Colors.red[900],
                                child: Container(
                                  height: 20,
                                  width: 120,
                                  child: Text(
                                    "Bắt Buộc Khảo Sát",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                            "${listSurvey[i].thanhvienId} - ${listSurvey[i].hoVaTen}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Icon(IconsCustomize.gender),
                              //     Text("Nữ",
                              //     style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                              //   ],
                              // ),
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
                                    listSurvey[i].ngaySinh.substring(0, 4),
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
        );
      },
    );
  }

  @override
  void initState() {
    services = Services.of(context);
    surVeyBloc =
        new SurveyBloc(services.sharePreferenceService, services.commonService);
    surVeyBloc.emitEvent(LoadSurveyEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Container(
      color: Colors.blue,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: screenHeight * 0.07,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  "Danh Sách Thành Viên Khảo Sát",
                  style: TextStyle(
                      color: Color(0xff003399),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: Colors.white),
          SliverList(
            delegate: SliverChildListDelegate(
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
                        padding: const EdgeInsets.only(left: 60, right: 60),
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
                                      "Cụm ID (10)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff9596ab)),
                                    ),
                                  ),
                                )),
                            Card(
                                elevation: 4.0,
                                child: Container(
                                  height: 30,
                                  width: 90,
                                  child: Center(
                                    child: Text(
                                      "B047",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
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
                        padding: const EdgeInsets.only(left: 60, right: 60),
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
                                      "Ngày Xuất Danh Sách",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff9596ab)),
                                    ),
                                  ),
                                )),
                            Card(
                                elevation: 4.0,
                                child: Container(
                                  height: 30,
                                  width: 90,
                                  child: Center(
                                    child: Text(
                                      "18-06-2020",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: orientation == Orientation.portrait
                      ? screenHeight * 0.774
                      : screenHeight * 0.654,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RawMaterialButton(
                            fillColor: Colors.grey,
                            splashColor: Colors.green,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Icon(
                                    Icons.system_update,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Cập Nhật Lên Server",
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {},
                            shape: const StadiumBorder(),
                          ),
                          RawMaterialButton(
                            fillColor: Colors.grey,
                            splashColor: Colors.green,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Icon(
                                    Icons.check_box,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "Chọn Tất Cả",
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {},
                            shape: const StadiumBorder(),
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          height: orientation == Orientation.portrait
                              ? screenHeight * 0.68
                              : screenHeight * 0.5,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              color: ColorConstants.cepColorBackground),
                          child: BlocEventStateBuilder<SurveyState>(
                            bloc: surVeyBloc,
                            builder: (BuildContext context, SurveyState state) {
                              return ModalProgressHUDCustomize(
                                inAsyncCall: state?.isLoading ?? false,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: null,
                                ),
                              );
                            },
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckBoxSurvey {
  int id;
  bool status;
}

// Widget buildSurveyListContainer(BuildContext context,SurveyBloc surVeyBloc) {
//     double screenWidth, screenHeight;
//     Orientation orientation = MediaQuery.of(context).orientation;
//     Size size = MediaQuery.of(context).size;
//     screenHeight = size.height;
//     screenWidth = size.width;
//     return Container(
//       color: Colors.blue,
//       child: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//               automaticallyImplyLeading: false,
//               expandedHeight: screenHeight * 0.07,
//               flexibleSpace: const FlexibleSpaceBar(
//                 title: Text(
//                   "Danh Sách Thành Viên Khảo Sát",
//                   style: TextStyle(
//                       color: Color(0xff003399),
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               backgroundColor: Colors.white),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               <Widget>[
//                 Container(
//                   height: orientation == Orientation.portrait
//                       ? screenHeight * 0.17
//                       : screenHeight * 0.3,
//                   decoration: BoxDecoration(
//                     borderRadius: new BorderRadius.only(
//                         bottomLeft: Radius.elliptical(260, 100)),
//                     color: Colors.white,
//                   ),
//                   //color: Colors.white,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 60, right: 60),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Card(
//                                 elevation: 4.0,
//                                 child: Container(
//                                   height: 30,
//                                   width: 90,
//                                   child: Center(
//                                     child: Text(
//                                       "Cụm ID (10)",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                           color: Color(0xff9596ab)),
//                                     ),
//                                   ),
//                                 )),
//                             Card(
//                                 elevation: 4.0,
//                                 child: Container(
//                                   height: 30,
//                                   width: 90,
//                                   child: Center(
//                                     child: Text(
//                                       "B047",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                           color: Colors.black),
//                                     ),
//                                   ),
//                                 )),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 60, right: 60),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Card(
//                                 elevation: 4.0,
//                                 child: Container(
//                                   height: 30,
//                                   width: 150,
//                                   child: Center(
//                                     child: Text(
//                                       "Ngày Xuất Danh Sách",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                           color: Color(0xff9596ab)),
//                                     ),
//                                   ),
//                                 )),
//                             Card(
//                                 elevation: 4.0,
//                                 child: Container(
//                                   height: 30,
//                                   width: 90,
//                                   child: Center(
//                                     child: Text(
//                                       "18-06-2020",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                           color: Colors.black),
//                                     ),
//                                   ),
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: orientation == Orientation.portrait
//                       ? screenHeight * 0.774
//                       : screenHeight * 0.654,
//                   color: Colors.blue,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           RawMaterialButton(
//                             fillColor: Colors.grey,
//                             splashColor: Colors.green,
//                             child: Padding(
//                               padding: EdgeInsets.all(10.0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: const <Widget>[
//                                   Icon(
//                                     Icons.system_update,
//                                     color: Colors.black,
//                                   ),
//                                   SizedBox(
//                                     width: 10.0,
//                                   ),
//                                   Text(
//                                     "Cập Nhật Lên Server",
//                                     maxLines: 1,
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             onPressed: () {},
//                             shape: const StadiumBorder(),
//                           ),
//                           RawMaterialButton(
//                             fillColor: Colors.grey,
//                             splashColor: Colors.green,
//                             child: Padding(
//                               padding: EdgeInsets.all(10.0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: const <Widget>[
//                                   Icon(
//                                     Icons.check_box,
//                                     color: Colors.black,
//                                   ),
//                                   SizedBox(
//                                     width: 10.0,
//                                   ),
//                                   Text(
//                                     "Chọn Tất Cả",
//                                     maxLines: 1,
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             onPressed: () {},
//                             shape: const StadiumBorder(),
//                           ),
//                         ],
//                       ),
//                       Container(
//                           margin: EdgeInsets.only(top: 10),
//                           height: orientation == Orientation.portrait
//                               ? screenHeight * 0.68
//                               : screenHeight * 0.5,
//                           width: screenWidth * 0.9,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(15),
//                               ),
//                               color: ColorConstants.cepColorBackground),
//                           child: BlocEventStateBuilder<SurveyState>(
//                             bloc: surVeyBloc,
//                             builder: (BuildContext context, SurveyState state) {
//                               return ModalProgressHUDCustomize(
//                                 inAsyncCall: state?.isLoading ?? false,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: StreamBuilder<List<SurveyInfo>>(
//                                       stream: surVeyBloc.getSurveys,
//                                       builder: (BuildContext context,
//                                           AsyncSnapshot<List<SurveyInfo>>
//                                               snapshot) {
//                                         List<SurveyInfo> listSurvey =
//                                             snapshot.data;
//                                         if (listSurvey == null) {
//                                           return Container(
//                                             child: null,
//                                           );
//                                         } else {
//                                           return getItemListView(listSurvey);
//                                         }
//                                       }),
//                                 ),
//                               );
//                             },
//                           ))
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget getItemListView(List<SurveyInfo> listSurvey) {
//     List<CheckBoxSurvey> checkBoxSurvey = new List<CheckBoxSurvey>();
//     for (var item in listSurvey) {
//       var model = new CheckBoxSurvey();
//       model.id = item.id;
//       model.status = false;
//       checkBoxSurvey.add(model);
//     }

//     int count = listSurvey != null ? listSurvey.length : 0;
//     return ListView.builder(
//       itemCount: count,
//       itemBuilder: (context, i) {
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(13),
//             ),
//             color: Colors.blue,
//           ),
//           height: 130,
//           child: Card(
//             elevation: 4,
//             shadowColor: Colors.blue,
//             color: Colors.white,
//             borderOnForeground: true,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 2, bottom: 8),
//               child: Row(
//                 children: [
//                   Checkbox(
//                     checkColor: Colors.white,
//                     activeColor: Colors.blue,
//                     value: checkBoxSurvey[i].status,
//                     onChanged: (bool value) {
//                       // setState(() {
//                       //   this.checkBoxSurvey[i].status = value;
//                       // });
//                     },
//                   ),
//                   Container(
//                     width: 290,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Card(
//                                 elevation: 3,
//                                 color: Colors.red,
//                                 child: Container(
//                                   height: 20,
//                                   width: 80,
//                                   child: Text(
//                                     "Đã Khảo Sát",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                         color: Colors.white),
//                                   ),
//                                 )),
//                             Card(
//                                 elevation: 3,
//                                 color: Colors.red[900],
//                                 child: Container(
//                                   height: 20,
//                                   width: 120,
//                                   child: Text(
//                                     "Bắt Buộc Khảo Sát",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                         color: Colors.white),
//                                   ),
//                                 )),
//                           ],
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 4),
//                           child: Text(
//                             "${listSurvey[i].thanhvienId} - ${listSurvey[i].hoVaTen}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 13),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.only(left: 4),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     IconsCustomize.gender,
//                                     size: 20,
//                                     color: Colors.blue,
//                                   ),
//                                   VerticalDivider(
//                                     width: 10,
//                                   ),
//                                   Container(
//                                     width: 30,
//                                     child: Text(
//                                       listSurvey[i].gioiTinh == 0
//                                           ? "Nữ"
//                                           : "Nam",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // Row(
//                               //   children: [
//                               //     Icon(IconsCustomize.gender),
//                               //     Text("Nữ",
//                               //     style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
//                               //   ],
//                               // ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: 4),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     IconsCustomize.birth_date,
//                                     size: 20,
//                                     color: Colors.red,
//                                   ),
//                                   VerticalDivider(
//                                     width: 10,
//                                   ),
//                                   VerticalDivider(
//                                     width: 1,
//                                   ),
//                                   Text(
//                                     listSurvey[i].ngaySinh.substring(0, 4),
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 13),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: 4),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     IconsCustomize.id_card,
//                                     color: Colors.orange,
//                                     size: 20,
//                                   ),
//                                   VerticalDivider(
//                                     width: 15,
//                                   ),
//                                   Text(
//                                     listSurvey[i].cmnd,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 13),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 5),
//                           padding: EdgeInsets.only(left: 6),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.location_on,
//                                 color: Colors.blue,
//                               ),
//                               VerticalDivider(
//                                 width: 1,
//                               ),
//                               Container(
//                                 width: 230,
//                                 child: Text(
//                                   listSurvey[i].diaChi,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 13),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
