import 'dart:io';

import 'package:flutter/material.dart';

import '../../GlobalTranslations.dart';
import '../../GlobalUser.dart';

class ItemDashBoard {
  String title;
  String img;
  IconData icon;
  String router;
  ItemDashBoard({this.title, this.img, this.icon, this.router});

  static List<ItemDashBoard> getItemDashboard() {
    List<ItemDashBoard> list = new List<ItemDashBoard>();
    list.add(new ItemDashBoard(
        title: allTranslations.text("Survey"),
        img: "assets/dashboard/survey.png",
        icon: Icons.library_books,
        router: globalUser.getUserInfo.chucVu == "register"
            ? "surveydetailfake"
            : "survey"));
    //globalUser.user = register
    if (Platform.isAndroid) {
      list.add(new ItemDashBoard(
          title: allTranslations.text("DeptRecovery"),
          img: "assets/dashboard/credit-hover.png",
          icon: Icons.attach_money,
          router: "deptcollection"));
      list.add(new ItemDashBoard(
          title: allTranslations.text("SavingAdvisory"),
          img: "assets/dashboard/saving-hover.png",
          icon: Icons.record_voice_over_outlined,
          router: "error"));
    }

    list.add(new ItemDashBoard(
        title: allTranslations.text("CommunityDevelopment"),
        img: "assets/dashboard/develop-hover.png",
        icon: Icons.people_rounded,
        router: globalUser.getUserInfo.chucVu == "register"
            ? "comunitydevelopmentdetailfake"
            : "comunitydevelopment"));
    list.add(new ItemDashBoard(
        title: allTranslations.text("Statistical"),
        img: "assets/dashboard/statistical-analysis.png",
        icon: Icons.insert_chart_outlined,
        router: "calculation"));
    list.add(new ItemDashBoard(
        title: allTranslations.text("DownLoad"),
        img: "assets/dashboard/document-download-outline.png",
        icon: Icons.download_rounded,
        router: "download"));
    list.add(new ItemDashBoard(
        title: allTranslations.text("InfoCustomer"),
        img: "assets/dashboard/document-download-outline.png",
        icon: Icons.download_rounded,
        router: globalUser.getUserInfo.chucVu == "register"
            ? "personalinforuserdetail"
            : "personalinforuser"));

    return list;
  }

  static List<ItemDashBoard> getItemMenuDefault() {
    List<ItemDashBoard> list = new List<ItemDashBoard>();
    list.add(new ItemDashBoard(
        title: allTranslations.text("DeleteData"),
        img: "",
        icon: Icons.delete_forever_rounded,
        router: "deletedata"));
    list.add(new ItemDashBoard(
        title: allTranslations.text("Settings"),
        img: "assets/dashboard/credit-hover.png",
        icon: Icons.settings,
        router: "setting"));
    list.add(new ItemDashBoard(
        title: allTranslations.text("Logout"),
        img: "assets/dashboard/credit-hover.png",
        icon: Icons.logout,
        router: "logout"));
    return list;
  }
}

//  Items item1 =
//       new Items(title: "Kh???o S??t", img: "assets/dashboard/survey.png");

//   Items item2 = new Items(
//     title: "Thu N???",
//     img: "assets/dashboard/credit-hover.png",
//   );
//   Items item3 = new Items(
//     title: "T?? V???n Ti???t Ki???m",
//     img: "assets/dashboard/saving-hover.png",
//   );
//   Items item4 = new Items(
//     title: "Ph??t Tri???n C???ng ?????ng",
//     img: "assets/dashboard/develop-hover.png",
//   );
//   Items item5 = new Items(
//     title: "Th???ng K??",
//     img: "assets/dashboard/statistical-analysis.png",
//   );
//   Items item6 = new Items(
//     title: "T???i Xu???ng",
//     img: "assets/dashboard/document-download-outline.png",
//   );
