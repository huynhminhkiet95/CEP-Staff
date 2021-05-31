import 'package:qr_code_demo/config/formatdate.dart';

class Announcement {
  int annId;
  String subject;
  String contents;
  String isUse;
  String expireDate;
  String createDate;
  int createUser;
  String createUserName;
  String updateDate;
  int updateUser;
  int agreedUser;
  String annType;
  String annTypeDesc;
  int isSign;
  String agreedDate;
  String requestforDriverAgreement;

  Announcement(
      {this.annId,
      this.annType,
      this.annTypeDesc,
      this.contents,
      this.createDate,
      this.createUser,
      this.createUserName,
      this.expireDate,
      this.isUse,
      this.subject,
      this.updateDate,
      this.updateUser,
      this.agreedUser,
      this.isSign,
      this.agreedDate,
      this.requestforDriverAgreement});
  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      annId: json["annId"] as int,
      annType: json["annType"] as String ?? '',
      annTypeDesc: json["annTypeDesc"] as String ?? '',
      contents: json["contents"] as String ?? '',
      subject: json["subject"] as String ?? '',
      createDate: convertTime(json["createDate"]),
      expireDate: convertTime(json["expireDate"]),
      agreedDate: convertTime(json["agreedDate"]),
      createUserName: json["createUserName"] as String ?? '',
      createUser: json["createUser"] as int,
      agreedUser: json["agreedUser"] as int,
      isSign: json["isSign"] as int,
      requestforDriverAgreement:
          json["requestforDriverAgreement"] as String ?? '',
    );
  }

  static String convertTime(int time) {
    var timeConvert = FormatDateConstants.convertUTCDate(time);
    return timeConvert;
  }
}
