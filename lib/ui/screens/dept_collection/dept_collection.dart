import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/models/personal_information_user/customer_info.dart';

class DeptCollectionScreen extends StatefulWidget {
  DeptCollectionScreen({Key key}) : super(key: key);

  _DeptCollectionScreenState createState() => _DeptCollectionScreenState();
}

class _DeptCollectionScreenState extends State<DeptCollectionScreen> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = ColorConstants.cepColorBackground;
  final secondary = Color(0xfff29a94);

  final List<Map> schoolLists = [
    {
      "name": "HKIET421 - HUỲNH MINH KIỆT - CN4",
      "location": "Ba Khâm, P.Nguyễn Nghiêm, TX.Đức Phổ, Quảng Ngãi",
      "id_card": "212275568",
      "gender": "Nam",
      "date": "22/02/2021"
    },
    {
      "name": "HKIET421 - HUỲNH MINH KIỆT - CN4",
      "location": "Ba Khâm, P.Nguyễn Nghiêm, TX.Đức Phổ, Quảng Ngãi",
      "id_card": "212275568",
      "gender": "Nam",
      "date": "22/02/2021"
    },
    {
      "name": "HKIET421 - HUỲNH MINH KIỆT - CN4",
      "location": "Ba Khâm, P.Nguyễn Nghiêm, TX.Đức Phổ, Quảng Ngãi",
      "id_card": "212275568",
      "gender": "Nam",
      "date": "22/02/2021"
    },
    {
      "name": "HKIET421 - HUỲNH MINH KIỆT - CN4",
      "location": "Ba Khâm, P.Nguyễn Nghiêm, TX.Đức Phổ, Quảng Ngãi",
      "id_card": "212275568",
      "gender": "Nam",
      "date": "22/02/2021"
    },
    {
      "name": "HKIET421 - HUỲNH MINH KIỆT - CN4",
      "location": "Ba Khâm, P.Nguyễn Nghiêm, TX.Đức Phổ, Quảng Ngãi",
      "id_card": "212275568",
      "gender": "Nam",
      "date": "22/02/2021"
    },
    {
      "name": "HKIET421 - HUỲNH MINH KIỆT - CN4",
      "location": "Ba Khâm, P.Nguyễn Nghiêm, TX.Đức Phổ, Quảng Ngãi",
      "id_card": "212275568",
      "gender": "Nam",
      "date": "22/02/2021"
    },
  ];
  TextEditingController _controllerCustomerName = new TextEditingController();
  List<Map> customerInfoList = new List<Map>();
  List<Map> customerInfoListAfterSearch = new List<Map>();
  //await DBProvider.db.newCustomerInfo(customerInfo);
  Future<List<Map>> getCustomerInfo() async {
    List<Map> listCustomerInfomation = schoolLists;
    await Future.delayed(Duration(seconds: 1), () {
      // 5 seconds over, navigate to Page2.
    });
    return listCustomerInfomation;
  }

  @override
  Widget build(BuildContext context) {
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
            allTranslations.text("DeptRecovery"),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            PopupMenuButton<String>(
              //   onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),

            //   DropD
          ],
        ),
        backgroundColor: Colors.grey[300],
        body: Container(
          child: FutureBuilder(
              future: getCustomerInfo(),
              builder: (context, snapshot) {
                customerInfoList = snapshot.data ?? new List<Map>();
                return ModalProgressHUD(
                  progressIndicator: RefreshProgressIndicator(
                    backgroundColor: Color(0xff223f92),
                  ),
                  color: Colors.grey,
                  inAsyncCall: !snapshot.hasData,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.69,
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: TextField(
                                      controller: _controllerCustomerName,
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      style: dropdownMenuItem,
                                      onChanged: (value) {
                                        // customerInfoListAfterSearch = customerInfoList
                                        //   .where((e) => e.fullName
                                        //       .contains(_controllerCustomerName.text))
                                        //   .toList();
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Tìm kiếm danh sách...",
                                          hintStyle: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 16),
                                          prefixIcon: Material(
                                            elevation: 0.0,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            child: Icon(Icons.search),
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 13)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    //margin: EdgeInsets.only(top: 70),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        )),
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      IconsCustomize.sliders_h,
                                      color: primary,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Builder(builder: (context) {
                            customerInfoListAfterSearch = customerInfoList;
                            if (customerInfoListAfterSearch.length > 0) {
                              return ListView.builder(
                                  itemCount: customerInfoListAfterSearch.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return buildList(context,
                                        customerInfoListAfterSearch[index]);
                                  });
                            } else {
                              return Container(
                                child: Center(
                                  child: Text(
                                    allTranslations.text("NoDataFound"),
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w700,
                                        wordSpacing: 1),
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.cepColorBackground,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            final result =
                await Navigator.pushNamed(context, 'personalinforuserdetail');
            if (result == true) {
              setState(() {});
            }
          },
        ));
  }

  Widget buildList(BuildContext context, Map customerInfo) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.pushNamed(
            context, 'personalinforuserupdate',
            arguments: {
              'customerInfo': customerInfo,
            });
        if (result == true) {
          setState(() {});
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/avatars/avatar.png"),
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Huỳnh Minh Kiệt',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    child: Icon(
                                      Icons.attach_money,
                                      color: secondary,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text('2.000.000',
                                          style: TextStyle(
                                              color: primary,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    child: Icon(
                                      Icons.date_range,
                                      color: secondary,
                                      size: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('25/08/2021',
                                      style: TextStyle(
                                          color: primary,
                                          fontSize: 13,
                                          letterSpacing: .3)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
