class UpdateInformationCustomer {
  String ngay;
  String makhachhang;
  List<TblThongtinthaydoi> tblThongtinthaydoi;
  List<UrlHinhanh> urlHinhanh;
  String usernameNhanvien;
  String ngaycapnhatNhanvien;
  int chinhanhid;
  String checksum;

  UpdateInformationCustomer(
      {this.ngay,
      this.makhachhang,
      this.tblThongtinthaydoi,
      this.urlHinhanh,
      this.usernameNhanvien,
      this.ngaycapnhatNhanvien,
      this.chinhanhid,
      this.checksum});

  UpdateInformationCustomer.fromJson(Map<String, dynamic> json) {
    ngay = json['ngay'];
    makhachhang = json['makhachhang'];
    if (json['tbl_thongtinthaydoi'] != null) {
      tblThongtinthaydoi = new List<TblThongtinthaydoi>();
      json['tbl_thongtinthaydoi'].forEach((v) {
        tblThongtinthaydoi.add(new TblThongtinthaydoi.fromJson(v));
      });
    }
    if (json['url_hinhanh'] != null) {
      urlHinhanh = new List<UrlHinhanh>();
      json['url_hinhanh'].forEach((v) {
        urlHinhanh.add(new UrlHinhanh.fromJson(v));
      });
    }
    usernameNhanvien = json['username_nhanvien'];
    ngaycapnhatNhanvien = json['ngaycapnhat_nhanvien'];
    chinhanhid = json['chinhanhid'];
    checksum = json['checksum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ngay'] = this.ngay;
    data['makhachhang'] = this.makhachhang;
    if (this.tblThongtinthaydoi != null) {
      data['tbl_thongtinthaydoi'] =
          this.tblThongtinthaydoi.map((v) => v.toJson()).toList();
    }
    if (this.urlHinhanh != null) {
      data['url_hinhanh'] = this.urlHinhanh.map((v) => v.toJson()).toList();
    }
    data['username_nhanvien'] = this.usernameNhanvien;
    data['ngaycapnhat_nhanvien'] = this.ngaycapnhatNhanvien;
    data['chinhanhid'] = this.chinhanhid;
    data['checksum'] = this.checksum;
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
    loaithongtinId = json['loaithongtin_id'];
    giatriCu = json['giatri_cu'];
    giatriMoi = json['giatri_moi'];
    ngaycap = json['ngaycap'];
    noicap = json['noicap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loaithongtin_id'] = this.loaithongtinId;
    data['giatri_cu'] = this.giatriCu;
    data['giatri_moi'] = this.giatriMoi;
    data['ngaycap'] = this.ngaycap;
    data['noicap'] = this.noicap;
    return data;
  }
}

class UrlHinhanh {
  int loaithongtinId;
  String urlHinhanh;
  bool ismattruoc;

  UrlHinhanh({this.loaithongtinId, this.urlHinhanh, this.ismattruoc});

  UrlHinhanh.fromJson(Map<String, dynamic> json) {
    loaithongtinId = json['loaithongtin_id'];
    urlHinhanh = json['url_hinhanh'];
    ismattruoc = json['ismattruoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loaithongtin_id'] = this.loaithongtinId;
    data['url_hinhanh'] = this.urlHinhanh;
    data['ismattruoc'] = this.ismattruoc;
    return data;
  }
}
