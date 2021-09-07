class UpdateInformationUser {
  String ngay;
  String makhachhang;
  List<TblThongtinthaydoi> tblThongtinthaydoi;
  List<UrlHinhanh> urlHinhanh;
  String usernameNhanvien;
  String ngaycapnhatNhanvien;
  int chinhanhid;
  int locateType;
  String latiLongTude;
  String checksum;

  UpdateInformationUser(
      {this.ngay,
      this.makhachhang,
      this.tblThongtinthaydoi,
      this.urlHinhanh,
      this.usernameNhanvien,
      this.ngaycapnhatNhanvien,
      this.chinhanhid,
      this.checksum});

  UpdateInformationUser.fromJson(Map<String, dynamic> json) {
    if (json["ngay"] is String) this.ngay = json["ngay"];
    if (json["makhachhang"] is String) this.makhachhang = json["makhachhang"];
    if (json["tbl_thongtinthaydoi"] is List)
      this.tblThongtinthaydoi = json["tbl_thongtinthaydoi"] == null
          ? null
          : (json["tbl_thongtinthaydoi"] as List)
              .map((e) => TblThongtinthaydoi.fromJson(e))
              .toList();
    if (json["url_hinhanh"] is List)
      this.urlHinhanh = json["url_hinhanh"] == null
          ? null
          : (json["url_hinhanh"] as List)
              .map((e) => UrlHinhanh.fromJson(e))
              .toList();
    if (json["username_nhanvien"] is String)
      this.usernameNhanvien = json["username_nhanvien"];
    if (json["ngaycapnhat_nhanvien"] is String)
      this.ngaycapnhatNhanvien = json["ngaycapnhat_nhanvien"];
    if (json["chinhanhid"] is int) this.chinhanhid = json["chinhanhid"];
    if (json["locateType"] is int) this.locateType = json["locateType"];
    if (json["latiLongTude"] is String)
      this.latiLongTude = json["latiLongTude"];
    if (json["checksum"] is String) this.checksum = json["checksum"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ngay"] = this.ngay;
    data["makhachhang"] = this.makhachhang;
    if (this.tblThongtinthaydoi != null)
      data["tbl_thongtinthaydoi"] =
          this.tblThongtinthaydoi.map((e) => e.toJson()).toList();
    if (this.urlHinhanh != null)
      data["url_hinhanh"] = this.urlHinhanh.map((e) => e.toJson()).toList();
    data["username_nhanvien"] = this.usernameNhanvien;
    data["ngaycapnhat_nhanvien"] = this.ngaycapnhatNhanvien;
    data["chinhanhid"] = this.chinhanhid;
    data["locateType"] = this.locateType;
    data["latiLongTude"] = this.latiLongTude;
    data["checksum"] = this.checksum;
    return data;
  }
}

class UrlHinhanh {
  int loaithongtinId;
  String urlHinhanh;
  bool ismattruoc;

  UrlHinhanh({this.loaithongtinId, this.urlHinhanh, this.ismattruoc});

  UrlHinhanh.fromJson(Map<String, dynamic> json) {
    if (json["loaithongtin_id"] is int)
      this.loaithongtinId = json["loaithongtin_id"];
    if (json["url_hinhanh"] is String) this.urlHinhanh = json["url_hinhanh"];
    if (json["ismattruoc"] is bool) this.ismattruoc = json["ismattruoc"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["loaithongtin_id"] = this.loaithongtinId;
    data["url_hinhanh"] = this.urlHinhanh;
    data["ismattruoc"] = this.ismattruoc;
    return data;
  }
}

class TblThongtinthaydoi {
  int loaithongtinId;
  String giatriCu;
  String giatriMoi;
  String ngaycap;
  String noicap;

  TblThongtinthaydoi(
      {this.loaithongtinId,
      this.giatriCu,
      this.giatriMoi,
      this.ngaycap,
      this.noicap});

  TblThongtinthaydoi.fromJson(Map<String, dynamic> json) {
    if (json["loaithongtin_id"] is int)
      this.loaithongtinId = json["loaithongtin_id"];
    if (json["giatri_cu"] is String) this.giatriCu = json["giatri_cu"];
    if (json["giatri_moi"] is String) this.giatriMoi = json["giatri_moi"];
    if (json["ngaycap"] is String) this.ngaycap = json["ngaycap"];
    if (json["noicap"] is String) this.noicap = json["noicap"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["loaithongtin_id"] = this.loaithongtinId;
    data["giatri_cu"] = this.giatriCu;
    data["giatri_moi"] = this.giatriMoi;
    data["ngaycap"] = this.ngaycap;
    data["noicap"] = this.noicap;
    return data;
  }
}
