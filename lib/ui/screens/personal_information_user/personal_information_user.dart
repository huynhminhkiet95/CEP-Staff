/**
 * Author: Sudip Thapa  
 * profile: https://github.com/sudeepthapa
  */

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/models/personal_information_user/customer_info.dart';

class PersonalInformationUser extends StatefulWidget {
  PersonalInformationUser({Key key}) : super(key: key);
  static final String path = "lib/src/pages/lists/list2.dart";

  _PersonalInformationUserState createState() =>
      _PersonalInformationUserState();
}

class _PersonalInformationUserState extends State<PersonalInformationUser> {
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
  //await DBProvider.db.newCustomerInfo(customerInfo);
  Future<List<CustomerInfo>> getCustomerInfo() async {
    List<CustomerInfo> listCustomerInfomation =
        await DBProvider.db.getCustomerInfo();
    return listCustomerInfomation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0f0f0),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 145),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: FutureBuilder(
                      future: getCustomerInfo(),
                      builder: (context, snapshot) {
                        List<CustomerInfo> customerInfoList =
                            snapshot.data ?? new List<CustomerInfo>();
                        return ModalProgressHUD(
                          progressIndicator: RefreshProgressIndicator(
                            backgroundColor: Color(0xff223f92),
                          ),
                          color: Colors.grey,
                          inAsyncCall: !snapshot.hasData,
                          child: Builder(builder: (context) {
                            if (customerInfoList.length > 0) {
                              return ListView.builder(
                                  itemCount: customerInfoList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return buildList(
                                        context, customerInfoList[index]);
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
                        );
                        // if (snapshot.hasData) {
                        //   List<CustomerInfo> customerInfoList = snapshot.data;
                        //   return ListView.builder(
                        //       itemCount: customerInfoList.length,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         return buildList(
                        //             context, customerInfoList[index]);
                        //       });
                        // } else {
                        //   return Container();
                        // }
                      }),
                ),
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Danh Sách Khách Hàng",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 110,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          elevation: 15.0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: TextField(
                            // controller: TextEditingController(text: locations[0]),
                            cursorColor: Theme.of(context).primaryColor,
                            style: dropdownMenuItem,
                            decoration: InputDecoration(
                                hintText: "Tìm kiếm bằng tên...",
                                hintStyle: TextStyle(
                                    color: Colors.black38, fontSize: 16),
                                prefixIcon: Material(
                                  elevation: 0.0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  child: Icon(Icons.search),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 13)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.cepColorBackground,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'personalinforuserdetail');
          },
        ));
  }

  Widget buildList(BuildContext context, CustomerInfo customerInfo) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 110,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   width: 50,
          //   height: 50,
          //   margin: EdgeInsets.only(right: 15),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     border: Border.all(width: 3, color: secondary),
          //     image: DecorationImage(
          //         image: NetworkImage(schoolLists[index]['logoText']),
          //         fit: BoxFit.fill),
          //   ),
          // ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    customerInfo.customerCode +
                        ' - ' +
                        customerInfo.fullName +
                        ' - ' +
                        'CN' +
                        customerInfo.branchId.toString(),
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      child: Icon(
                        Icons.location_on,
                        color: secondary,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(customerInfo.nativePlace,
                            style: TextStyle(
                                color: primary,
                                fontSize: 13,
                                letterSpacing: .3)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            child: Icon(
                              IconsCustomize.id_card_1,
                              color: secondary,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(customerInfo.oldId,
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 13,
                                  letterSpacing: .3)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            child: Icon(
                              IconsCustomize.gender,
                              color: secondary,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(customerInfo.sex,
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 13,
                                  letterSpacing: .3)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 20,
                            child: Icon(
                              Icons.date_range_outlined,
                              color: secondary,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(customerInfo.dob,
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
          )
        ],
      ),
    );
  }
}
