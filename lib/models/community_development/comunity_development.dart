class ComunityDevelopment {
  List<KhachHang> khachHang;

  ComunityDevelopment({this.khachHang});

  ComunityDevelopment.fromJson(Map<String, dynamic> json) {
    if (json["khachHang"] is List)
      this.khachHang = json["khachHang"] == null
          ? []
          : (json["khachHang"] as List)
              .map((e) => KhachHang.fromJson(e))
              .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.khachHang != null)
      data["khachHang"] = this.khachHang.map((e) => e.toJson()).toList();
    return data;
  }
}

class KhachHang {
  int id;
  String maKhachHang;
  double chinhanhId;
  double duanId;
  String masoql;
  String cumId;
  String hoTen;
  String thanhVienId;
  String cmnd;
  double gioitinh;
  String ngaysinh;
  String diachi;
  String dienthoai;
  double lanvay;
  String thoigianthamgia;
  double thanhVienThuocDien;
  String maHongheoCanngheo;
  double ngheNghiep;
  String ghiChu;
  bool moHinhNghe;
  double thunhapHangthangCuaho;
  bool coVoChongConLaCnv;
  BHYT bhyt;
  HocBong hocBong;
  MaiNha maiNha;
  PhatTrienNghe phatTrienNghe;
  QuaTet quaTet;
  bool isCheckHocBong;
  bool isCheckQuaTet;
  bool isCheckMaiNha;
  bool isCheckPhatTrienNghe;
  bool isCheckBHYT;
  KhachHang(
      {this.id,
      this.maKhachHang,
      this.chinhanhId,
      this.duanId,
      this.masoql,
      this.cumId,
      this.hoTen,
      this.thanhVienId,
      this.cmnd,
      this.gioitinh,
      this.ngaysinh,
      this.diachi,
      this.dienthoai,
      this.lanvay,
      this.thoigianthamgia,
      this.thanhVienThuocDien,
      this.maHongheoCanngheo,
      this.ngheNghiep,
      this.ghiChu,
      this.moHinhNghe,
      this.thunhapHangthangCuaho,
      this.coVoChongConLaCnv,
      this.bhyt,
      this.hocBong,
      this.maiNha,
      this.phatTrienNghe,
      this.quaTet,
      this.isCheckHocBong,
      this.isCheckQuaTet,
      this.isCheckMaiNha,
      this.isCheckPhatTrienNghe,
      this.isCheckBHYT});

  KhachHang.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["maKhachHang"] is String) this.maKhachHang = json["maKhachHang"];
    if (json["chinhanhID"] is double) {
      this.chinhanhId = json["chinhanhID"];
    }
    if (json["duanID"] != null) {
      this.duanId = json["duanID"];
    }
    if (json["masoql"] is String) this.masoql = json["masoql"];
    if (json["cumID"] is String) this.cumId = json["cumID"];
    if (json["hoTen"] is String) this.hoTen = json["hoTen"];
    if (json["thanhVienID"] is String) this.thanhVienId = json["thanhVienID"];
    if (json["cmnd"] is String) this.cmnd = json["cmnd"];
    if (json["gioitinh"] is double) this.gioitinh = json["gioitinh"];
    if (json["ngaysinh"] is String) this.ngaysinh = json["ngaysinh"];
    if (json["diachi"] is String) this.diachi = json["diachi"];
    if (json["dienthoai"] is String) this.dienthoai = json["dienthoai"];
    if (json["lanvay"] is double) this.lanvay = json["lanvay"];
    if (json["thoigianthamgia"] is String)
      this.thoigianthamgia = json["thoigianthamgia"];
    if (json["thanhVienThuocDien"] is double)
      this.thanhVienThuocDien = json["thanhVienThuocDien"];
    if (json["maHongheoCanngheo"] is String)
      this.maHongheoCanngheo = json["maHongheoCanngheo"];
    if (json["ngheNghiep"] is double) this.ngheNghiep = json["ngheNghiep"];
    if (json["ghiChu"] is String) this.ghiChu = json["ghiChu"];
    if (json["moHinhNghe"] is bool) this.moHinhNghe = json["moHinhNghe"];
    if (json["thunhapHangthangCuaho"] is double)
      this.thunhapHangthangCuaho = json["thunhapHangthangCuaho"];
    if (json["coVoChongConLaCNV"] is bool)
      this.coVoChongConLaCnv = json["coVoChongConLaCNV"];
    if (json["bhyt"] is Map)
      this.bhyt = json["bhyt"] == null ? null : BHYT.fromJson(json["bhyt"]);
    if (json["hocBong"] is Map)
      this.hocBong =
          json["hocBong"] == null ? null : HocBong.fromJson(json["hocBong"]);
    if (json["maiNha"] is Map)
      this.maiNha =
          json["maiNha"] == null ? null : MaiNha.fromJson(json["maiNha"]);
    if (json["phatTrienNghe"] is Map)
      this.phatTrienNghe = json["phatTrienNghe"] == null
          ? null
          : PhatTrienNghe.fromJson(json["phatTrienNghe"]);
    if (json["quaTet"] is Map)
      this.quaTet =
          json["quaTet"] == null ? null : QuaTet.fromJson(json["quaTet"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["maKhachHang"] = this.maKhachHang;
    data["chinhanhID"] = this.chinhanhId;
    data["duanID"] = this.duanId;
    data["masoql"] = this.masoql;
    data["cumID"] = this.cumId;
    data["hoTen"] = this.hoTen;
    data["thanhVienID"] = this.thanhVienId;
    data["cmnd"] = this.cmnd;
    data["gioitinh"] = this.gioitinh;
    data["ngaysinh"] = this.ngaysinh;
    data["diachi"] = this.diachi;
    data["dienthoai"] = this.dienthoai;
    data["lanvay"] = this.lanvay;
    data["thoigianthamgia"] = this.thoigianthamgia;
    data["thanhVienThuocDien"] = this.thanhVienThuocDien;
    data["maHongheoCanngheo"] = this.maHongheoCanngheo;
    data["ngheNghiep"] = this.ngheNghiep;
    data["ghiChu"] = this.ghiChu;
    data["moHinhNghe"] = this.moHinhNghe;
    data["thunhapHangthangCuaho"] = this.thunhapHangthangCuaho;
    data["coVoChongConLaCNV"] = this.coVoChongConLaCnv;
    data["bhyt"] = this.bhyt;
    data["hocBong"] = this.hocBong;
    if (this.maiNha != null) data["maiNha"] = this.maiNha.toJson();
    if (this.phatTrienNghe != null)
      data["phatTrienNghe"] = this.phatTrienNghe.toJson();
    if (this.quaTet != null) data["quaTet"] = this.quaTet.toJson();
    return data;
  }

  factory KhachHang.fromMap(Map<String, dynamic> json) {
    return new KhachHang(
        id: json["id"],
        maKhachHang: json["maKhachHang"],
        chinhanhId: (json["chinhanhID"] ?? 0).toDouble(),
        duanId: (json["duanID"] ?? 0).toDouble(),
        masoql: json["masoql"],
        cumId: json["cumID"],
        hoTen: json["hoTen"],
        thanhVienId: json["thanhVienID"],
        cmnd: json["cmnd"],
        gioitinh: (json["gioitinh"] as int).toDouble(),
        ngaysinh: json["ngaysinh"],
        diachi: json["diachi"],
        dienthoai: json["dienthoai"],
        lanvay: (json["lanvay"] ?? 0).toDouble(),
        thoigianthamgia: json["thoigianthamgia"],
        thanhVienThuocDien: (json["thanhVienThuocDien"] ?? 0).toDouble(),
        maHongheoCanngheo: json["maHongheoCanngheo"],
        ngheNghiep: (json["ngheNghiep"] ?? 0).toDouble(),
        ghiChu: json["ghiChu"],
        moHinhNghe: json["moHinhNghe"] == 0 ? false : true,
        thunhapHangthangCuaho: (json["thunhapHangthangCuaho"] ?? 0).toDouble(),
        coVoChongConLaCnv: json["coVoChongConLaCNV"] == 0 ? false : true,
        isCheckHocBong: json["isCheckHocBong"] == 1 ? true : false,
        isCheckQuaTet: json["isCheckQuaTet"] == 1 ? true : false,
        isCheckMaiNha: json["isCheckMaiNha"] == 1 ? true : false,
        isCheckPhatTrienNghe: json["isCheckPhatTrienNghe"] == 1 ? true : false,
        isCheckBHYT: json["isCheckBHYT"] == 1 ? true : false);
  }
}

class QuaTet {
  int idKhachhang;
  int serverId;
  double nam;
  String maKhachHang;
  double loaiHoNgheo;

  QuaTet(
      {this.idKhachhang,
      this.serverId,
      this.nam,
      this.maKhachHang,
      this.loaiHoNgheo});

  QuaTet.fromJson(Map<String, dynamic> json) {
    if (json["idKhachhang"] != null) this.idKhachhang = json["idKhachhang"];
    if (json["serverID"] != null) this.serverId = json["serverID"];
    if (json["nam"] != null) this.nam = (json["nam"] ?? 0).toDouble();
    if (json["maKhachHang"] is String) this.maKhachHang = json["maKhachHang"];
    if (json["loaiHoNgheo"] != null) {
      this.loaiHoNgheo = (json["loaiHoNgheo"] ?? 0).toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["serverID"] = this.serverId;
    data["nam"] = this.nam;
    data["maKhachHang"] = this.maKhachHang;
    data["loaiHoNgheo"] = this.loaiHoNgheo;
    return data;
  }
}

class PhatTrienNghe {
  int idKhachhang;
  int serverId;
  double nam;
  String maKhachHang;
  String nguoithan;
  double quanHeKhacHang;
  double lyDo;
  String hoancanh;
  double nguyenvongthamgia;
  double nguyenvonghoithao;
  double scCnguyenvong;
  double iecDnguyenvong;
  double reacHnguyenvong;

  PhatTrienNghe(
      {this.idKhachhang,
      this.serverId,
      this.nam,
      this.maKhachHang,
      this.nguoithan,
      this.quanHeKhacHang,
      this.lyDo,
      this.hoancanh,
      this.nguyenvongthamgia,
      this.nguyenvonghoithao,
      this.scCnguyenvong,
      this.iecDnguyenvong,
      this.reacHnguyenvong});

  PhatTrienNghe.fromJson(Map<String, dynamic> json) {
    if (json["idKhachhang"] is int) this.idKhachhang = json["idKhachhang"];
    if (json["serverID"] != null) this.serverId = json["serverID"];
    if (json["nam"] != null) this.nam = (json["nam"] ?? 0).toDouble();
    if (json["maKhachHang"] is String) this.maKhachHang = json["maKhachHang"];
    if (json["nguoithan"] is String) this.nguoithan = json["nguoithan"];
    if (json["quanHeKhacHang"] != null)
      this.quanHeKhacHang = (json["quanHeKhacHang"] ?? 0).toDouble();
    if (json["lyDo"] != null) this.lyDo = (json["lyDo"] ?? 0).toDouble();
    if (json["hoancanh"] is String) this.hoancanh = json["hoancanh"];
    if (json["nguyenvongthamgia"] != null)
      this.nguyenvongthamgia = (json["nguyenvongthamgia"] ?? 0).toDouble();
    if (json["nguyenvonghoithao"] != null)
      this.nguyenvonghoithao = (json["nguyenvonghoithao"] ?? 0).toDouble();
    if (json["scCnguyenvong"] != null)
      this.scCnguyenvong = (json["scCnguyenvong"] ?? 0).toDouble();
    if (json["iecDnguyenvong"] != null)
      this.iecDnguyenvong = (json["iecDnguyenvong"] ?? 0).toDouble();
    if (json["reacHnguyenvong"] != null)
      this.reacHnguyenvong = (json["reacHnguyenvong"] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["serverID"] = this.serverId;
    data["nam"] = this.nam;
    data["maKhachHang"] = this.maKhachHang;
    data["nguoithan"] = this.nguoithan;
    data["quanHeKhacHang"] = this.quanHeKhacHang;
    data["lyDo"] = this.lyDo;
    data["hoancanh"] = this.hoancanh;
    data["nguyenvongthamgia"] = this.nguyenvongthamgia;
    data["nguyenvonghoithao"] = this.nguyenvonghoithao;
    data["scCnguyenvong"] = this.scCnguyenvong;
    data["iecDnguyenvong"] = this.iecDnguyenvong;
    data["reacHnguyenvong"] = this.reacHnguyenvong;
    return data;
  }
}

class MaiNha {
  int idKhachhang;
  int serverId;
  double nam;
  String maKhachHang;
  double tilephuthuoc;
  double thunhap;
  double taisan;
  double dieukiennhao;
  double quyenSoHuuNha;
  String ghichuhoancanh;
  double cbDexuat;
  double duTruKinhPhi;
  double deXuatHoTro;
  double giaDinhHoTro;
  double tietKiem;
  double tienVay;
  bool giaDinhDongY;
  double cnDexuat;
  String cnDexuatThoigian;
  double cnDexuatSotien;
  double hosodinhkem;

  MaiNha(
      {this.idKhachhang,
      this.serverId,
      this.nam,
      this.maKhachHang,
      this.tilephuthuoc,
      this.thunhap,
      this.taisan,
      this.dieukiennhao,
      this.quyenSoHuuNha,
      this.ghichuhoancanh,
      this.cbDexuat,
      this.duTruKinhPhi,
      this.deXuatHoTro,
      this.giaDinhHoTro,
      this.tietKiem,
      this.tienVay,
      this.giaDinhDongY,
      this.cnDexuat,
      this.cnDexuatThoigian,
      this.cnDexuatSotien,
      this.hosodinhkem});

  MaiNha.fromJson(Map<String, dynamic> json) {
    if (json["idKhachhang"] is int) this.idKhachhang = json["idKhachhang"];
    if (json["serverID"] is int) this.serverId = json["serverID"];
    if (json["nam"] != null) this.nam = (json["nam"] ?? 0).toDouble();
    if (json["maKhachHang"] is String) this.maKhachHang = json["maKhachHang"];
    if (json["tilephuthuoc"] != null)
      this.tilephuthuoc = (json["tilephuthuoc"] ?? 0).toDouble();
    if (json["thunhap"] != null)
      this.thunhap = (json["thunhap"] ?? 0).toDouble();
    if (json["taisan"] != null) this.taisan = (json["taisan"] ?? 0).toDouble();
    if (json["dieukiennhao"] != null)
      this.dieukiennhao = (json["dieukiennhao"] ?? 0).toDouble();
    if (json["quyenSoHuuNha"] != null)
      this.quyenSoHuuNha = (json["quyenSoHuuNha"] ?? 0).toDouble();
    if (json["ghichuhoancanh"] is String)
      this.ghichuhoancanh = json["ghichuhoancanh"];
    if (json["cbDexuat"] != null)
      this.cbDexuat = (json["cbDexuat"] ?? 0).toDouble();
    if (json["duTruKinhPhi"] != null)
      this.duTruKinhPhi = (json["duTruKinhPhi"] ?? 0).toDouble();
    if (json["deXuatHoTro"] != null)
      this.deXuatHoTro = (json["deXuatHoTro"] ?? 0).toDouble();
    if (json["giaDinhHoTro"] != null)
      this.giaDinhHoTro = (json["giaDinhHoTro"] ?? 0).toDouble();
    if (json["tietKiem"] != null)
      this.tietKiem = (json["tietKiem"] ?? 0).toDouble();
    if (json["tienVay"] != null)
      this.tienVay = (json["tienVay"] ?? 0).toDouble();
    if (json["giaDinhDongY"] != null)
      this.giaDinhDongY = json["giaDinhDongY"] == 1 ? true : false;
    if (json["cnDexuat"] != null)
      this.cnDexuat = (json["cnDexuat"] ?? 0).toDouble();
    if (json["cnDexuatThoigian"] is String)
      this.cnDexuatThoigian = json["cnDexuatThoigian"];
    if (json["cnDexuatSotien"] != null)
      this.cnDexuatSotien = (json["cnDexuatSotien"] ?? 0).toDouble();
    if (json["hosodinhkem"] != null)
      this.hosodinhkem = (json["hosodinhkem"] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["serverID"] = this.serverId;
    data["nam"] = this.nam;
    data["maKhachHang"] = this.maKhachHang;
    data["tilephuthuoc"] = this.tilephuthuoc;
    data["thunhap"] = this.thunhap;
    data["taisan"] = this.taisan;
    data["dieukiennhao"] = this.dieukiennhao;
    data["quyenSoHuuNha"] = this.quyenSoHuuNha;
    data["ghichuhoancanh"] = this.ghichuhoancanh;
    data["cbDexuat"] = this.cbDexuat;
    data["duTruKinhPhi"] = this.duTruKinhPhi;
    data["deXuatHoTro"] = this.deXuatHoTro;
    data["giaDinhHoTro"] = this.giaDinhHoTro;
    data["tietKiem"] = this.tietKiem;
    data["tienVay"] = this.tienVay;
    data["giaDinhDongY"] = this.giaDinhDongY;
    data["cnDexuat"] = this.cnDexuat ?? 0;
    data["cnDexuatThoigian"] = this.cnDexuatThoigian;
    data["cnDexuatSotien"] = this.cnDexuatSotien ?? 0;
    data["hosodinhkem"] = this.hosodinhkem;
    return data;
  }
}

class BHYT {
  int idKhachhang;
  int serverId;
  double nam;
  String maKhachHang;
  double mucphibaohiem;
  double dieukienbhyt;
  double tinhtrangsuckhoe;
  String nguoithan;
  double namsinh;
  double quanHeKhachHang;

  BHYT(
      {this.idKhachhang,
      this.serverId,
      this.nam,
      this.maKhachHang,
      this.mucphibaohiem,
      this.dieukienbhyt,
      this.tinhtrangsuckhoe,
      this.nguoithan,
      this.namsinh,
      this.quanHeKhachHang});

  BHYT.fromJson(Map<String, dynamic> json) {
    if (json["idKhachhang"] != null) this.idKhachhang = json["idKhachhang"];
    if (json["serverID"] != null) this.serverId = json["serverID"];
    if (json["nam"] != null) this.nam = json["nam"].toDouble();
    if (json["maKhachHang"] != null) this.maKhachHang = json["maKhachHang"];
    if (json["mucphibaohiem"] != null)
      this.mucphibaohiem = json["mucphibaohiem"].toDouble();
    if (json["dieukienbhyt"] != null)
      this.dieukienbhyt = json["dieukienbhyt"].toDouble();
    if (json["tinhtrangsuckhoe"] != null)
      this.tinhtrangsuckhoe = json["tinhtrangsuckhoe"].toDouble();
    if (json["nguoithan"] != null) this.nguoithan = json["nguoithan"];
    if (json["namsinh"] != null) this.namsinh = json["namsinh"].toDouble();
    if (json["quanHeKhachHang"] != null)
      this.quanHeKhachHang = json["quanHeKhachHang"].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["serverID"] = this.serverId;
    data["nam"] = this.nam;
    data["maKhachHang"] = this.maKhachHang;
    data["mucphibaohiem"] = this.mucphibaohiem;
    data["dieukienbhyt"] = this.dieukienbhyt;
    data["tinhtrangsuckhoe"] = this.tinhtrangsuckhoe;
    data["nguoithan"] = this.nguoithan;
    data["namsinh"] = this.namsinh;
    data["quanHeKhachHang"] = this.quanHeKhachHang;

    return data;
  }
}

class HocBong {
  int idKhachhang;
  int serverID;
  double nam;
  String maKhachHang;
  String hotenhocsinh;
  double namsinh;
  double lop;
  String truonghoc;
  double quanhekhachhang;
  double hocbong_Quatang;
  double hocluc;
  bool danhanhocbong; // bool
  double dinhKemHoSo;
  double hoancanhhocsinh;
  String hoancanhgiadinh;
  double mucdich;
  String ghiChu;
  double giatri;

  HocBong(
      {this.idKhachhang,
      this.serverID,
      this.nam,
      this.maKhachHang,
      this.hotenhocsinh,
      this.namsinh,
      this.lop,
      this.truonghoc,
      this.quanhekhachhang,
      this.hocbong_Quatang,
      this.hocluc,
      this.danhanhocbong,
      this.dinhKemHoSo,
      this.hoancanhhocsinh,
      this.hoancanhgiadinh,
      this.mucdich,
      this.ghiChu,
      this.giatri});

  HocBong.fromJson(Map<String, dynamic> json) {
    idKhachhang = json['idKhachhang'];
    serverID = json['serverID'];
    nam = (json["nam"] ?? 0).toDouble();
    maKhachHang = json['maKhachHang'];
    hotenhocsinh = json['hotenhocsinh'];
    namsinh = (json['namsinh'] ?? 0).toDouble();
    lop = (json['lop'] ?? 0).toDouble();
    truonghoc = json['truonghoc'];
    quanhekhachhang = (json['quanhekhachhang'] ?? 0).toDouble();
    hocbong_Quatang = (json['hocbong_Quatang'] ?? 2).toDouble();
    hocluc = (json['hocluc'] ?? 0).toDouble();
    danhanhocbong = json['danhanhocbong'] == 0 ? false : true;
    dinhKemHoSo = (json['dinhKemHoSo'] ?? 0).toDouble();
    hoancanhhocsinh = (json['hoancanhhocsinh'] ?? 0).toDouble();
    hoancanhgiadinh = json['hoancanhgiadinh'];
    mucdich = (json['mucdich'] ?? 0).toDouble();
    ghiChu = json['ghiChu'];
    giatri = (json['giatri'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serverID'] = this.serverID;
    data['nam'] = this.nam;
    data['maKhachHang'] = this.maKhachHang;
    data['hotenhocsinh'] = this.hotenhocsinh;
    data['namsinh'] = this.namsinh;
    data['lop'] = this.lop;
    data['truonghoc'] = this.truonghoc;
    data['quanhekhachhang'] = this.quanhekhachhang;
    data['hocbong_Quatang'] = this.hocbong_Quatang;
    data['hocluc'] = this.hocluc;
    data['danhanhocbong'] = this.danhanhocbong;
    data['dinhKemHoSo'] = this.dinhKemHoSo;
    data['hoancanhhocsinh'] = this.hoancanhhocsinh;
    data['hoancanhgiadinh'] = this.hoancanhgiadinh;
    data['mucdich'] = this.mucdich;
    data['ghiChu'] = this.ghiChu;
    data['giatri'] = this.giatri;
    return data;
  }

  HocBong.fromMap(Map<String, dynamic> json) {
    idKhachhang = json['idKhachhang'];
    serverID = json['serverID'];
    nam = (json["nam"] ?? 0).toDouble();
    maKhachHang = json['maKhachHang'];
    hotenhocsinh = json['hotenhocsinh'];
    namsinh = (json['namsinh'] ?? 0).toDouble();
    lop = (json['lop'] ?? 0).toDouble();
    truonghoc = json['truonghoc'];
    quanhekhachhang = (json['quanhekhachhang'] ?? 0).toDouble();
    hocbong_Quatang = (json['hocbongQuatang'] ?? 2).toDouble();
    hocluc = (json['hocluc'] ?? 0).toDouble();
    danhanhocbong = json['danhanhocbong'] == 0 ? false : true;
    dinhKemHoSo = (json['dinhKemHoSo'] ?? 0).toDouble();
    hoancanhhocsinh = (json['hoancanhhocsinh'] ?? 0).toDouble();
    hoancanhgiadinh = json['hoancanhgiadinh'];
    mucdich = (json['mucdich'] ?? 0).toDouble();
    ghiChu = json['ghiChu'];
    giatri = (json['giatri'] ?? 0).toDouble();
  }
}

class CheckBoxCommunityDevelopment {
  int id;
  bool status;
}
