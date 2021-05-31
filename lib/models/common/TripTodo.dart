import 'package:qr_code_demo/config/formatdate.dart';

class TripTodo {
  String bookNo;
  int bookDate;
  String pickUpPlace;
  String pickUpPlaceDetail;
  int pickupTime;
  String returnPlace;
  String returnPlaceDetail;
  int returnTime;
  String bookStatus;
  String assignedFleet;
  String staffName;
  String icon;
  String bookTime;
  String pickupDate;
  String returnDate;
  int bRId;
  int fleetId;
  int bookAccept;
  int isPickUp;
  String customerName;
  String mobileNo;

  TripTodo({
    this.bookNo,
    this.bookDate,
    this.pickUpPlace,
    this.pickUpPlaceDetail,
    this.pickupTime,
    this.returnPlace,
    this.returnPlaceDetail,
    this.returnTime,
    this.bookStatus,
    this.assignedFleet,
    this.staffName,
    this.icon,
    this.bookTime,
    this.pickupDate,
    this.returnDate,
    this.bRId,
    this.bookAccept,
    this.fleetId,
    this.customerName,
    this.mobileNo,
    this.isPickUp,
  });
  factory TripTodo.fromJson(Map<String, dynamic> json) {
    return TripTodo(
      bookNo: json["bookNo"] as String,
      bookDate: json["bookDate"] as int,
      pickUpPlace: json["pickUpPlace"] as String,
      pickUpPlaceDetail: json["pickUpPlaceDetail"] as String,
      pickupTime: json["pickupTime"] as int,
      returnPlace: json["returnPlace"] as String,
      returnPlaceDetail: json["returnPlaceDetail"] as String,
      returnTime: json["returnTime"] as int,
      bookStatus: json["bookStatus"] as String,
      assignedFleet: json["assignedFleet"] as String,
      staffName: json["staffName"] as String,
      icon: getIconBasedOnStatus(json["bookStatus"] as String),
      bookTime: convertTime(json["bookDate"] as int),
      pickupDate: convertTime(json["pickupTime"] as int),
      returnDate: convertTime(json["returnTime"] as int),
      bRId: json["brId"] as int,
      bookAccept: json["bookAccept"] as int,
      fleetId: json["fleetId"] as int,
      isPickUp: json["isPickUp"] as int,
      customerName: json["customerName"] as String ?? '',
      mobileNo: json["mobileNo"] as String ?? '',
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
