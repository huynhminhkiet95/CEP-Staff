
class VersionStaff {
  int id;
  String tenDuAn;
  String tenPhienBan;
  int maPhienBan;
  String ngay;

  VersionStaff({this.id, this.tenDuAn, this.tenPhienBan, this.maPhienBan, this.ngay});

  VersionStaff.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int)
      this.id = json["id"];
    if(json["tenDuAn"] is String)
      this.tenDuAn = json["tenDuAn"];
    if(json["tenPhienBan"] is String)
      this.tenPhienBan = json["tenPhienBan"];
    if(json["maPhienBan"] is int)
      this.maPhienBan = json["maPhienBan"];
    if(json["ngay"] is String)
      this.ngay = json["ngay"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["tenDuAn"] = this.tenDuAn;
    data["tenPhienBan"] = this.tenPhienBan;
    data["maPhienBan"] = this.maPhienBan;
    data["ngay"] = this.ngay;
    return data;
  }
}