import 'package:qr_code_demo/config/formatdate.dart';

class CheckList {
  int clId;
  int checkDate;
  String shipmentNo;
  String equipmentCode;
  String driverId;
  String driverName;
  int createDate;
  String createUser;
  String createUserName;
  double totalScore;
  String finalResult;
  String isApproval;
  String approveUser;
  int approveDate;
  String linksWeb;
  double totalAllocatedScore;
  double scorePercent;
  String approveUserName;
  CheckList({
    this.clId,
    this.checkDate,
    this.shipmentNo,
    this.equipmentCode,
    this.driverId,
    this.driverName,
    this.createDate,
    this.createUser,
    this.createUserName,
    this.totalScore,
    this.finalResult,
    this.isApproval,
    this.approveUser,
    this.approveDate,
    this.linksWeb,
    this.totalAllocatedScore,
    this.scorePercent,
    this.approveUserName,
  });
  factory CheckList.fromJson(Map<String, dynamic> json) {
    return CheckList(
      clId: json["clId"] as int,
      checkDate: json["checkDate"] as int,
      shipmentNo: json["shipmentNo"] as String ?? '',
      equipmentCode: json["equipmentCode"] as String ?? '',
      driverId: json["driverId"] as String,
      driverName: json["driverName"] as String ?? '',
      createDate: json["createDate"] as int,
      createUser: json["createUser"] as String,
      createUserName: json["createUserName"] as String ?? '',
      totalScore: json["totalScore"] as double,
      finalResult: json["finalResult"] as String ?? '',
      isApproval: json["isApproval"] as String,
      approveUser: json["isApproval"] as String ?? '',
      approveDate: json["approveDate"] as int,
      linksWeb: json["linksWeb"] as String ?? '',
      totalAllocatedScore: json["totalAllocatedScore"] as double,
      scorePercent: json["scorePercent"] as double,
      approveUserName: json["approveUserName"] as String ?? '',
    );
  }

  static String convertTime(int time) {
    var timeConvert = FormatDateConstants.convertUTCDateTimeShort(time);
    return timeConvert;
  }

  static String getIconBasedOnStatus(String status) {
    String iconUrl = "";
    switch (status) {
      case "Assigned":
        iconUrl = "assets/images/icon_confirm_status.png";
        break;
      case "CONFIRM":
        iconUrl = "assets/images/icon_confirm_status.png";
        break;
      case "PICKUP_ARRIVAL":
        iconUrl = "assets/images/icon_start_delivery_status.png";
        break;
      case "START_DELIVERY":
        iconUrl = "assets/images/icon_start_delivery_status.png";
        break;
      case "COMPLETED":
        iconUrl = "assets/images/icon_completed_status.png";
        break;
    }
    return iconUrl;
  }
}
