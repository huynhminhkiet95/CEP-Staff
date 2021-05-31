class HistorySearchSurvey {
  int id;
  String cumID;
  String ngayXuatDanhSach;
  String username;
  String masoql;

  HistorySearchSurvey({this.id,this.cumID, this.ngayXuatDanhSach, this.username, this.masoql});

  // HistorySearchSurvey.fromJson(Map<String, dynamic> json) {
  //   if (json["cumID"] is int)
  //     this.cumID = json["cumID"];
  //   if (json["NgayXuatDanhSach"] is String)
  //     this.ngayXuatDanhSach = json["NgayXuatDanhSach"];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data["cumID"] = this.cumID;
  //   data["NgayXuatDanhSach"] = this.ngayXuatDanhSach;
  //   return data;
  // }

  factory HistorySearchSurvey.fromMap(Map<String, dynamic> json) =>
      new HistorySearchSurvey(
          id: json["id"], 
          cumID: json["cumID"], 
          ngayXuatDanhSach: json["ngayXuatDanhSach"],
          username: json["username"],
          masoql: json["masoql"],
          );
}
