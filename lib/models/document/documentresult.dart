import 'package:qr_code_demo/config/formatdate.dart';

class GetDocumentResult {
  String docRefType;
  String refNoType;
  String refNoValue;
  String filePath;
  String fileType;
  double fileSize;
  String createDate;
  int createUser;
  String updateDate;
  int updateUser;
  int docNo;
  String dFileName;
  GetDocumentResult(
      {this.docRefType,
      this.refNoType,
      this.refNoValue,
      this.filePath,
      this.fileType,
      this.fileSize,
      this.createDate,
      this.createUser,
      this.dFileName,
      this.docNo,
      this.updateDate,
      this.updateUser});
  factory GetDocumentResult.fromJson(Map<String, dynamic> json) {
    return GetDocumentResult(
      docRefType: json["docRefType"] as String,
      refNoType: json["refNoType"] as String ?? '',
      refNoValue: json["refNoValue"] as String ?? '',
      filePath: json["filePath"] as String ?? '',
      fileType: json["fileType"] as String ?? '',
      fileSize: json["fileSize"] as double ?? null,
      createDate: convertTime(json["createDate"]),
      updateDate: convertTime(json["updateDate"]),
      createUser: json["createUser"] as int,
      updateUser: json["updateUser"] as int ?? null,
      dFileName: json["dFileName"] as String,
      docNo: json["docNo"] as int,
    );
  }

  static String convertTime(int time) {
    var timeConvert = FormatDateConstants.convertUTCDate(time);
    return timeConvert;
  }
}
