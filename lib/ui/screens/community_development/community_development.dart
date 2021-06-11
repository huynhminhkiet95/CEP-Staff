import 'dart:async';

import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/global_variables/global_teamID.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
import 'package:qr_code_demo/ui/screens/Home/styles.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/community_development/community_development_bloc.dart';
import 'package:qr_code_demo/blocs/community_development/community_development_event.dart';
import 'package:qr_code_demo/blocs/community_development/community_development_state.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:flutter/rendering.dart';
import '../../../GlobalTranslations.dart';

class CommunityDevelopmentScreen extends StatefulWidget {
  @override
  _CommunityDevelopmentScreenState createState() =>
      _CommunityDevelopmentScreenState();
}

class _CommunityDevelopmentScreenState extends State<CommunityDevelopmentScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  double screenWidth, screenHeight;
  TabController _tabController;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  //List<bool> isActiveForList = new List<bool>();
  List<bool> isActiveForListScholarship = new List<bool>();
  List<bool> isActiveForListGiftTet = new List<bool>();
  List<bool> isActiveForListRoof = new List<bool>();
  List<bool> isActiveForListDevelopOccupation = new List<bool>();
  List<bool> isActiveForListInsurance = new List<bool>();

  var arrActive = new List(6);
  CommunityDevelopmentBloc communityDevelopmentBloc;
  Services services;
  bool isInitLoad;
  TextEditingController _controllerTeamID = new TextEditingController(text: "");
  List<String> listTeamID;
  bool isValidator = false;
  final isValidatorStream = StreamController<bool>();
  @override
  void initState() {
    isInitLoad = true;
    loadItemTeamID();
    _controllerTeamID.text = globalUser.getCumIdOfCommunityDevelopment == null
        ? ""
        : globalUser.getCumIdOfCommunityDevelopment.toUpperCase();
    arrActive[0] = new List<bool>();
    arrActive[1] = new List<bool>();
    arrActive[2] = new List<bool>();
    arrActive[3] = new List<bool>();
    arrActive[4] = new List<bool>();
    arrActive[5] = new List<bool>();
    _tabController = new TabController(length: 6, vsync: this);
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    services = Services.of(context);
    communityDevelopmentBloc = new CommunityDevelopmentBloc(
        services.sharePreferenceService, services.commonService);
    communityDevelopmentBloc.emitEvent(LoadCommunityDevelopmentEvent());

    super.initState();
  }

  loadItemTeamID() async {
    listTeamID = await DBProvider.db.getListTeamIDCommunityDevelopment();
  }

  @override
  void dispose() {
    animationController?.dispose();
    isValidatorStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
              //bool a = GlobalDownload.isSubmitDownload;
            },
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 20,
          title: const Text('Phát triển Cộng Đồng',
              style: TextStyle(fontWeight: FontWeight.w600)),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {})
          ],
        ),
        body: BlocEventStateBuilder<CommunityDevelopmentState>(
            bloc: communityDevelopmentBloc,
            builder: (BuildContext context, CommunityDevelopmentState state) {
              return Container(
                color: ColorConstants.cepColorBackground,
                child: ModalProgressHUDCustomize(
                  inAsyncCall: state?.isLoading ?? false,
                  child: StreamBuilder<List<KhachHang>>(
                      stream: communityDevelopmentBloc
                          .getCommunityDevelopmentStream,
                      builder: (context, snapshot) {
                        if (snapshot.data != null && snapshot.data.length > 0) {
                          List<KhachHang> listCommunityDevelopmentAll =
                              snapshot.data;
                          var a = listCommunityDevelopmentAll
                              .where((e) => e.hocBong.serverID != 0)
                              .toList();
                          List<KhachHang>
                              listCommunityDevelopmentForScholarship =
                              listCommunityDevelopmentAll
                                  .where((e) => e.hocBong.serverID != 0)
                                  .toList();
                          List<KhachHang> listCommunityDevelopmentForGiftTet =
                              listCommunityDevelopmentAll
                                  .where((e) => e.quaTet.serverId != 0)
                                  .toList();
                          List<KhachHang> listCommunityDevelopmentForRoof =
                              listCommunityDevelopmentAll
                                  .where((e) => e.maiNha.serverId != 0)
                                  .toList();
                          List<KhachHang>
                              listCommunityDevelopmentForDevelopOccupation =
                              listCommunityDevelopmentAll
                                  .where((e) => e.phatTrienNghe.serverId != 0)
                                  .toList();
                          List<KhachHang> listCommunityDevelopmentForInsurance =
                              listCommunityDevelopmentAll
                                  .where((e) => e.bhyt.serverId != 0)
                                  .toList();

                          if (isInitLoad == true ||
                              arrActive[0].length !=
                                  listCommunityDevelopmentAll.length) {
                            arrActive[0] = List<bool>.generate(
                                listCommunityDevelopmentAll.length,
                                (int index) => false);
                            arrActive[1] = List<bool>.generate(
                                listCommunityDevelopmentForScholarship.length,
                                (int index) => false);
                            arrActive[2] = List<bool>.generate(
                                listCommunityDevelopmentForGiftTet.length,
                                (int index) => false);
                            arrActive[3] = List<bool>.generate(
                                listCommunityDevelopmentForRoof.length,
                                (int index) => false);
                            arrActive[4] = List<bool>.generate(
                                listCommunityDevelopmentForDevelopOccupation
                                    .length,
                                (int index) => false);
                            arrActive[5] = List<bool>.generate(
                                listCommunityDevelopmentForInsurance.length,
                                (int index) => false);
                            isInitLoad = false;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.only(
                                      bottomLeft: Radius.elliptical(260, 100),
                                      // topRight: Radius.elliptical(260, 100),
                                    ),
                                    color: Theme.of(context).accentColor,
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, top: 30),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: size.width * 0.2,
                                            child: Center(
                                              child: const Text(
                                                "Cụm ID",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Color(0xff9596ab)),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: size.width * 0.45,
                                                child: Center(
                                                  child:
                                                      SimpleAutoCompleteTextField(
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.blue),
                                                    key: key,
                                                    controller:
                                                        _controllerTeamID,
                                                    suggestions: listTeamID,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              0.0,
                                                              15.0,
                                                              20.0,
                                                              15.0),
                                                      labelStyle: new TextStyle(
                                                          color: Colors.red),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                    textSubmitted: null,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              StreamBuilder<bool>(
                                                  stream:
                                                      isValidatorStream.stream,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.data == null ||
                                                        snapshot.data ==
                                                            false) {
                                                      return Container();
                                                    } else {
                                                      return Text(
                                                          "*Cụm này hiện không có dữ liệu !",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 12));
                                                    }
                                                  }),
                                            ],
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.search,
                                                size: 25,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                int index = listTeamID.indexOf(
                                                    _controllerTeamID.text
                                                        .toUpperCase());

                                                if (index != -1) {
                                                  if (_controllerTeamID.text !=
                                                      globalUser
                                                          .getCumIdOfCommunityDevelopment) {
                                                    isInitLoad = true;
                                                    communityDevelopmentBloc.emitEvent(
                                                        SearchCommunityDevelopmentEvent(
                                                            _controllerTeamID
                                                                .text
                                                                .toUpperCase()));
                                                    isValidatorStream.sink
                                                        .add(false);
                                                  }
                                                } else {
                                                  isValidatorStream.sink
                                                      .add(true);
                                                }
                                              })
                                        ],
                                      ))

                                  //  color: Colors.blue,
                                  ),
                              Material(
                                color: ColorConstants.cepColorBackground,
                                child: TabBar(
                                  isScrollable: true,
                                  unselectedLabelColor:
                                      Colors.blueGrey.shade300,
                                  indicatorColor: Colors.red,
                                  labelColor: Colors.white,
                                  tabs: [
                                    Tab(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Icon(Icons.list),
                                          ),
                                          Center(
                                              child: Text(
                                            'Tất Cả (${listCommunityDevelopmentAll.length})',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Icon(
                                                IconsCustomize.scholarship),
                                          ),
                                          Center(
                                              child: Text(
                                            'Học Bổng (${listCommunityDevelopmentForScholarship.length})',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Icon(IconsCustomize.quatet),
                                          ),
                                          Center(
                                              child: Text(
                                            'Quà Tết (${listCommunityDevelopmentForGiftTet.length})',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Icon(IconsCustomize.mainha),
                                          ),
                                          Center(
                                              child: Text(
                                            'Mái Nhà (${listCommunityDevelopmentForRoof.length})',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Icon(IconsCustomize.ptnghe),
                                          ),
                                          Center(
                                              child: Text(
                                            'PT Nghề (${listCommunityDevelopmentForDevelopOccupation.length})',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        children: [
                                          Center(
                                            child:
                                                Icon(IconsCustomize.insurance),
                                          ),
                                          Center(
                                              child: Text(
                                            'Bảo Hiểm (${listCommunityDevelopmentForInsurance.length})',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                  controller: _tabController,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    Container(
                                        color: Colors.white,
                                        child: getItemListView(
                                            listCommunityDevelopmentAll, 0)),
                                    Container(
                                        color: Colors.white,
                                        child: getItemListView(
                                            listCommunityDevelopmentForScholarship,
                                            1)),
                                    Container(
                                        color: Colors.white,
                                        child: getItemListView(
                                            listCommunityDevelopmentForGiftTet,
                                            2)),
                                    Container(
                                        color: Colors.white,
                                        child: getItemListView(
                                            listCommunityDevelopmentForRoof,
                                            3)),
                                    Container(
                                        color: Colors.white,
                                        child: getItemListView(
                                            listCommunityDevelopmentForDevelopOccupation,
                                            4)),
                                    Container(
                                        color: Colors.white,
                                        child: getItemListView(
                                            listCommunityDevelopmentForInsurance,
                                            5)),
                                  ],
                                  controller: _tabController,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ModalProgressHUDCustomize(
                              inAsyncCall: state?.isLoading,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/no_data.gif',
                                          width: 150, height: 150),
                                      Text(
                                        allTranslations.text("NoDataFound"),
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w700,
                                            wordSpacing: 1),
                                      ),
                                      Text(
                                        allTranslations
                                            .text("ClickThisButtonToDownload"),
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w700,
                                            wordSpacing: 1),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          _navigateAndDisplaySelection(context);
                                        },
                                        child: Text(
                                          allTranslations.text("DownLoad"),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        color: Colors.cyan,
                                        textColor: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        }
                      }),
                ),
              );
            }));
  }

  Widget getItemListView(List<KhachHang> listItem, int index) {
    // int indexOf = listTeamID.indexOf(_controllerTeamID.text);
    // if (_controllerTeamID.text !=
    //     globalUser.getCumIdOfCommunityDevelopment.toUpperCase() && indexOf < 0) {
    //   animationController.reset();
    // }

    return new Container(
        color: Colors.grey[300],
        child: new ListView.builder(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: listItem.length,
            itemBuilder: (context, i) {
              int count = listItem.length;
              Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
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
                            setState(() {
                              if (arrActive[index][i] == true) {
                                arrActive[index][i] = !arrActive[index][i];
                              } else {
                                arrActive[index] = List<bool>.generate(
                                    listItem.length, (int index) => false);
                                arrActive[index][i] = true;
                              }
                            });
                          },
                          child: new Container(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 5),
                            child: Card(
                              elevation: 4,
                              semanticContainer: false,
                              shadowColor: Colors.grey,
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                height: 100,
                                color: arrActive[index][i] == false
                                    ? Colors.white10
                                    : Colors.lightGreen[200],
                                child: Stack(
                                  children: [
                                    new AnimatedPositioned(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.linearToEaseOut,
                                      left: arrActive[index][i] == false
                                          ? screenWidth * 1
                                          : (screenWidth * 1) - 98,
                                      width: 70,
                                      //top: 35,
                                      child: Container(
                                        height: 100,
                                        color: Colors.red,
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              List<ComboboxModel> listCombobox =
                                                  globalUser
                                                      .getListComboboxModel;
                                              if (listCombobox == null ||
                                                  listCombobox.length == 0) {
                                                Navigator.pushNamed(
                                                    context, 'download',
                                                    arguments: {
                                                      'selectedIndex': 4,
                                                    }).then(
                                                    (value) => setState(() {
                                                          if (true == value) {}
                                                        }));
                                              } else {
                                                Navigator.pushNamed(context,
                                                    'comunitydevelopmentdetail',
                                                    arguments: {
                                                      'khachhang': listItem[i],
                                                      'metadata': listCombobox,
                                                    }).then((value) {
                                                  if (true == value) {
                                                    communityDevelopmentBloc
                                                        .emitEvent(
                                                            LoadCommunityDevelopmentEvent());
                                                  }
                                                });
                                              }
                                            }),
                                      ),
                                    ),
                                    new AnimatedPositioned(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.linearToEaseOut,
                                      right:
                                          arrActive[index][i] == false ? 0 : 70,
                                      child: AnimatedContainer(
                                        width: screenWidth * 0.927,
                                        height: 100,
                                        padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.only(
                                        //     right: isActiveForList[i] == false ? 0 : 60),
                                        duration: Duration(milliseconds: 500),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(
                                                    arrActive[index][i] == false
                                                        ? 10
                                                        : 0),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(
                                                    arrActive[index][i] == false
                                                        ? 10
                                                        : 0)),
                                            // borderRadius: BorderRadius.all(
                                            //   Radius.circular(10),
                                            // ),
                                            color: arrActive[index][i] == false
                                                ? Colors.white10
                                                : Colors.lightGreen[200]),
                                        // Provide an optional curve to make the animation feel smoother.
                                        curve: Curves.fastOutSlowIn,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 4, bottom: 5),
                                              child: Text(
                                                listItem[i].thanhVienId +
                                                    ' - ' +
                                                    listItem[i].hoTen,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 4),
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
                                                          listItem[i].gioitinh ==
                                                                  0
                                                              ? "Nữ"
                                                              : "Nam",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 4),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        IconsCustomize
                                                            .birth_date,
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
                                                        listItem[i]
                                                            .ngaysinh
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
                                                  padding:
                                                      EdgeInsets.only(left: 4),
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
                                                        listItem[i].cmnd,
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
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.blue,
                                                  ),
                                                  VerticalDivider(
                                                    width: 1,
                                                  ),
                                                  Container(
                                                    width: screenWidth * 0.8,
                                                    child: Text(
                                                      listItem[i].diachi,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, 'download', arguments: {
      'selectedIndex': 3,
    });
    if (result == true) {
      communityDevelopmentBloc.emitEvent(LoadCommunityDevelopmentEvent());
      _controllerTeamID.text = globalUser.getCumIdOfCommunityDevelopment == null
          ? ""
          : globalUser.getCumIdOfCommunityDevelopment.toUpperCase();
    }
  }
}
