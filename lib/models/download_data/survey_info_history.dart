
class SurveyInfoHistory {
  String ngayXuatDanhSach;
  String masoCanBoKhaoSat;
  int chinhanhId;
  String cumId;
  String thanhvienId;
  String tinhTrangHonNhan;
  String trinhDoHocVan;
  int khuVuc;
  int lanvay;
  String nguoiTraloiKhaoSat;
  int songuoiTrongHo;
  int songuoiCoviecLam;
  int dientichDatTrong;
  int giaTriVatNuoi;
  int dungCuLaoDong;
  int phuongTienDiLai;
  int taiSanSinhHoat;
  String quyenSoHuuNha;
  int hemTruocNha;
  String maiNha;
  String tuongNha;
  String nenNha;
  int dienTichNhaTinhTren1Nguoi;
  String dien;
  String nuoc;
  String mucDichSudungVon;
  int soTienCanThiet;
  int soTienThanhVienDaCo;
  int soTienCanVay;
  String thoiDiemSuDungVonvay;
  int tongVonDauTu;
  int thuNhapRongHangThang;
  int thuNhapCuaVoChong;
  int thuNhapCuaCacCon;
  int thuNhapKhac;
  int tongChiPhiCuaThanhvien;
  int chiPhiDienNuoc;
  int chiPhiAnUong;
  int chiPhiHocTap;
  int chiPhiKhac;
  int chiTraTienVayHangThang;
  int tichLuyTangThemHangThang;
  String nguonVay1;
  int sotienVay1;
  String lyDoVay1;
  String thoiDiemTatToan1;
  String bienPhapThongNhat1;
  String nguonVay2;
  int sotienVay2;
  String lyDoVay2;
  String thoiDiemTatToan2;
  String bienPhapThongNhat2;
  String thanhVienThuocDien;
  String maSoHoNgheo;
  String hoTenChuHo;
  int soTienGuiTietKiemMoiKy;
  int tietKiemBatBuocXinRut;
  int tietKiemTuNguyenXinRut;
  int tietKiemLinhHoatXinRut;
  String thoiDiemRut;
  int mucVayBoSung;
  String mucDichVayBoSung;
  String ngayVayBoSung;
  String ghiChu;
  int soTienDuyetChovay;
  int tietKiemDinhHuong;
  String mucDichVay;
  String duyetChovayNgay;
  int daCapNhatVaoHoSoChovay;

  SurveyInfoHistory({this.ngayXuatDanhSach, this.masoCanBoKhaoSat, this.chinhanhId, this.cumId, this.thanhvienId, this.tinhTrangHonNhan, this.trinhDoHocVan, this.khuVuc, this.lanvay, this.nguoiTraloiKhaoSat, this.songuoiTrongHo, this.songuoiCoviecLam, this.dientichDatTrong, this.giaTriVatNuoi, this.dungCuLaoDong, this.phuongTienDiLai, this.taiSanSinhHoat, this.quyenSoHuuNha, this.hemTruocNha, this.maiNha, this.tuongNha, this.nenNha, this.dienTichNhaTinhTren1Nguoi, this.dien, this.nuoc, this.mucDichSudungVon, this.soTienCanThiet, this.soTienThanhVienDaCo, this.soTienCanVay, this.thoiDiemSuDungVonvay, this.tongVonDauTu, this.thuNhapRongHangThang, this.thuNhapCuaVoChong, this.thuNhapCuaCacCon, this.thuNhapKhac, this.tongChiPhiCuaThanhvien, this.chiPhiDienNuoc, this.chiPhiAnUong, this.chiPhiHocTap, this.chiPhiKhac, this.chiTraTienVayHangThang, this.tichLuyTangThemHangThang, this.nguonVay1, this.sotienVay1, this.lyDoVay1, this.thoiDiemTatToan1, this.bienPhapThongNhat1, this.nguonVay2, this.sotienVay2, this.lyDoVay2, this.thoiDiemTatToan2, this.bienPhapThongNhat2, this.thanhVienThuocDien, this.maSoHoNgheo, this.hoTenChuHo, this.soTienGuiTietKiemMoiKy, this.tietKiemBatBuocXinRut, this.tietKiemTuNguyenXinRut, this.tietKiemLinhHoatXinRut, this.thoiDiemRut, this.mucVayBoSung, this.mucDichVayBoSung, this.ngayVayBoSung, this.ghiChu, this.soTienDuyetChovay, this.tietKiemDinhHuong, this.mucDichVay, this.duyetChovayNgay, this.daCapNhatVaoHoSoChovay});

  SurveyInfoHistory.fromJson(Map<String, dynamic> json) {
    if(json["NgayXuatDanhSach"] is String)
      this.ngayXuatDanhSach = json["NgayXuatDanhSach"].trim();
    if(json["MasoCanBoKhaoSat"] is String)
      this.masoCanBoKhaoSat = json["MasoCanBoKhaoSat"].trim();
    if(json["ChinhanhID"] is int)
      this.chinhanhId = json["ChinhanhID"];
    if(json["CumID"] is String)
      this.cumId = json["CumID"].trim();
    if(json["ThanhvienID"] is String)
      this.thanhvienId = json["ThanhvienID"].trim();
    if(json["TinhTrangHonNhan"] is String)
      this.tinhTrangHonNhan = json["TinhTrangHonNhan"].trim();
    if(json["TrinhDoHocVan"] is String)
      this.trinhDoHocVan = json["TrinhDoHocVan"].trim();
    if(json["KhuVuc"] is int)
      this.khuVuc = json["KhuVuc"];
    if(json["Lanvay"] is int)
      this.lanvay = json["Lanvay"];
    if(json["NguoiTraloiKhaoSat"] is String)
      this.nguoiTraloiKhaoSat = json["NguoiTraloiKhaoSat"].trim();
    if(json["SonguoiTrongHo"] is int)
      this.songuoiTrongHo = json["SonguoiTrongHo"];
    if(json["SonguoiCoviecLam"] is int)
      this.songuoiCoviecLam = json["SonguoiCoviecLam"];
    if(json["DientichDatTrong"] is int)
      this.dientichDatTrong = json["DientichDatTrong"];
    if(json["GiaTriVatNuoi"] is int)
      this.giaTriVatNuoi = json["GiaTriVatNuoi"];
    if(json["DungCuLaoDong"] is int)
      this.dungCuLaoDong = json["DungCuLaoDong"];
    if(json["PhuongTienDiLai"] is int)
      this.phuongTienDiLai = json["PhuongTienDiLai"];
    if(json["TaiSanSinhHoat"] is int)
      this.taiSanSinhHoat = json["TaiSanSinhHoat"];
    if(json["QuyenSoHuuNha"] is String)
      this.quyenSoHuuNha = json["QuyenSoHuuNha"].trim();
    if(json["HemTruocNha"] is int)
      this.hemTruocNha = json["HemTruocNha"];
    if(json["MaiNha"] is String)
      this.maiNha = json["MaiNha"].trim();
    if(json["TuongNha"] is String)
      this.tuongNha = json["TuongNha"].trim();
    if(json["NenNha"] is String)
      this.nenNha = json["NenNha"].trim();
    if(json["DienTichNhaTinhTren1Nguoi"] is int)
      this.dienTichNhaTinhTren1Nguoi = json["DienTichNhaTinhTren1Nguoi"];
    if(json["Dien"] is String)
      this.dien = json["Dien"].trim();
    if(json["Nuoc"] is String)
      this.nuoc = json["Nuoc"].trim();
    if(json["MucDichSudungVon"] is String)
      this.mucDichSudungVon = json["MucDichSudungVon"].trim();
    if(json["SoTienCanThiet"] is int)
      this.soTienCanThiet = json["SoTienCanThiet"];
    if(json["SoTienThanhVienDaCo"] is int)
      this.soTienThanhVienDaCo = json["SoTienThanhVienDaCo"];
    if(json["SoTienCanVay"] is int)
      this.soTienCanVay = json["SoTienCanVay"];
    if(json["ThoiDiemSuDungVonvay"] is String)
      this.thoiDiemSuDungVonvay = json["ThoiDiemSuDungVonvay"].trim();
    if(json["TongVonDauTu"] is int)
      this.tongVonDauTu = json["TongVonDauTu"];
    if(json["ThuNhapRongHangThang"] is int)
      this.thuNhapRongHangThang = json["ThuNhapRongHangThang"];
    if(json["ThuNhapCuaVoChong"] is int)
      this.thuNhapCuaVoChong = json["ThuNhapCuaVoChong"];
    if(json["ThuNhapCuaCacCon"] is int)
      this.thuNhapCuaCacCon = json["ThuNhapCuaCacCon"];
    if(json["ThuNhapKhac"] is int)
      this.thuNhapKhac = json["ThuNhapKhac"];
    if(json["TongChiPhiCuaThanhvien"] is int)
      this.tongChiPhiCuaThanhvien = json["TongChiPhiCuaThanhvien"];
    if(json["ChiPhiDienNuoc"] is int)
      this.chiPhiDienNuoc = json["ChiPhiDienNuoc"];
    if(json["ChiPhiAnUong"] is int)
      this.chiPhiAnUong = json["ChiPhiAnUong"];
    if(json["ChiPhiHocTap"] is int)
      this.chiPhiHocTap = json["ChiPhiHocTap"];
    if(json["ChiPhiKhac"] is int)
      this.chiPhiKhac = json["ChiPhiKhac"];
    if(json["ChiTraTienVayHangThang"] is int)
      this.chiTraTienVayHangThang = json["ChiTraTienVayHangThang"];
    if(json["TichLuyTangThemHangThang"] is int)
      this.tichLuyTangThemHangThang = json["TichLuyTangThemHangThang"];
    if(json["NguonVay1"] is String)
      this.nguonVay1 = json["NguonVay1"].trim();
    if(json["SotienVay1"] is int)
      this.sotienVay1 = json["SotienVay1"];
    if(json["LyDoVay1"] is String)
      this.lyDoVay1 = json["LyDoVay1"].trim();
    if(json["ThoiDiemTatToan1"] is String)
      this.thoiDiemTatToan1 = json["ThoiDiemTatToan1"].trim();
    if(json["BienPhapThongNhat1"] is String)
      this.bienPhapThongNhat1 = json["BienPhapThongNhat1"].trim();
    if(json["NguonVay2"] is String)
      this.nguonVay2 = json["NguonVay2"].trim();
    if(json["SotienVay2"] is int)
      this.sotienVay2 = json["SotienVay2"];
    if(json["LyDoVay2"] is String)
      this.lyDoVay2 = json["LyDoVay2"].trim();
    if(json["ThoiDiemTatToan2"] is String)
      this.thoiDiemTatToan2 = json["ThoiDiemTatToan2"].trim();
    if(json["BienPhapThongNhat2"] is String)
      this.bienPhapThongNhat2 = json["BienPhapThongNhat2"].trim();
    if(json["ThanhVienThuocDien"] is String)
      this.thanhVienThuocDien = json["ThanhVienThuocDien"].trim();
    if(json["MaSoHoNgheo"] is String)
      this.maSoHoNgheo = json["MaSoHoNgheo"].trim();
    if(json["HoTenChuHo"] is String)
      this.hoTenChuHo = json["HoTenChuHo"].trim();
    if(json["SoTienGuiTietKiemMoiKy"] is int)
      this.soTienGuiTietKiemMoiKy = json["SoTienGuiTietKiemMoiKy"];
    if(json["TietKiemBatBuocXinRut"] is int)
      this.tietKiemBatBuocXinRut = json["TietKiemBatBuocXinRut"];
    if(json["TietKiemTuNguyenXinRut"] is int)
      this.tietKiemTuNguyenXinRut = json["TietKiemTuNguyenXinRut"];
    if(json["TietKiemLinhHoatXinRut"] is int)
      this.tietKiemLinhHoatXinRut = json["TietKiemLinhHoatXinRut"];
    if(json["ThoiDiemRut"] is String)
      this.thoiDiemRut = json["ThoiDiemRut"].trim();
    if(json["MucVayBoSung"] is int)
      this.mucVayBoSung = json["MucVayBoSung"];
    if(json["MucDichVayBoSung"] is String)
      this.mucDichVayBoSung = json["MucDichVayBoSung"].trim();
    if(json["NgayVayBoSung"] is String)
      this.ngayVayBoSung = json["NgayVayBoSung"].trim();
    if(json["GhiChu"] is String)
      this.ghiChu = json["GhiChu"].trim();
    if(json["SoTienDuyetChovay"] is int)
      this.soTienDuyetChovay = json["SoTienDuyetChovay"];
    if(json["TietKiemDinhHuong"] is int)
      this.tietKiemDinhHuong = json["TietKiemDinhHuong"];
    if(json["MucDichVay"] is String)
      this.mucDichVay = json["MucDichVay"].trim();
    if(json["DuyetChovayNgay"] is String)
      this.duyetChovayNgay = json["DuyetChovayNgay"].trim();
    if(json["DaCapNhatVaoHoSoChovay"] is int)
      this.daCapNhatVaoHoSoChovay = json["DaCapNhatVaoHoSoChovay"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["NgayXuatDanhSach"] = this.ngayXuatDanhSach;
    data["MasoCanBoKhaoSat"] = this.masoCanBoKhaoSat;
    data["ChinhanhID"] = this.chinhanhId;
    data["CumID"] = this.cumId;
    data["ThanhvienID"] = this.thanhvienId;
    data["TinhTrangHonNhan"] = this.tinhTrangHonNhan;
    data["TrinhDoHocVan"] = this.trinhDoHocVan;
    data["KhuVuc"] = this.khuVuc;
    data["Lanvay"] = this.lanvay;
    data["NguoiTraloiKhaoSat"] = this.nguoiTraloiKhaoSat;
    data["SonguoiTrongHo"] = this.songuoiTrongHo;
    data["SonguoiCoviecLam"] = this.songuoiCoviecLam;
    data["DientichDatTrong"] = this.dientichDatTrong;
    data["GiaTriVatNuoi"] = this.giaTriVatNuoi;
    data["DungCuLaoDong"] = this.dungCuLaoDong;
    data["PhuongTienDiLai"] = this.phuongTienDiLai;
    data["TaiSanSinhHoat"] = this.taiSanSinhHoat;
    data["QuyenSoHuuNha"] = this.quyenSoHuuNha;
    data["HemTruocNha"] = this.hemTruocNha;
    data["MaiNha"] = this.maiNha;
    data["TuongNha"] = this.tuongNha;
    data["NenNha"] = this.nenNha;
    data["DienTichNhaTinhTren1Nguoi"] = this.dienTichNhaTinhTren1Nguoi;
    data["Dien"] = this.dien;
    data["Nuoc"] = this.nuoc;
    data["MucDichSudungVon"] = this.mucDichSudungVon;
    data["SoTienCanThiet"] = this.soTienCanThiet;
    data["SoTienThanhVienDaCo"] = this.soTienThanhVienDaCo;
    data["SoTienCanVay"] = this.soTienCanVay;
    data["ThoiDiemSuDungVonvay"] = this.thoiDiemSuDungVonvay;
    data["TongVonDauTu"] = this.tongVonDauTu;
    data["ThuNhapRongHangThang"] = this.thuNhapRongHangThang;
    data["ThuNhapCuaVoChong"] = this.thuNhapCuaVoChong;
    data["ThuNhapCuaCacCon"] = this.thuNhapCuaCacCon;
    data["ThuNhapKhac"] = this.thuNhapKhac;
    data["TongChiPhiCuaThanhvien"] = this.tongChiPhiCuaThanhvien;
    data["ChiPhiDienNuoc"] = this.chiPhiDienNuoc;
    data["ChiPhiAnUong"] = this.chiPhiAnUong;
    data["ChiPhiHocTap"] = this.chiPhiHocTap;
    data["ChiPhiKhac"] = this.chiPhiKhac;
    data["ChiTraTienVayHangThang"] = this.chiTraTienVayHangThang;
    data["TichLuyTangThemHangThang"] = this.tichLuyTangThemHangThang;
    data["NguonVay1"] = this.nguonVay1;
    data["SotienVay1"] = this.sotienVay1;
    data["LyDoVay1"] = this.lyDoVay1;
    data["ThoiDiemTatToan1"] = this.thoiDiemTatToan1;
    data["BienPhapThongNhat1"] = this.bienPhapThongNhat1;
    data["NguonVay2"] = this.nguonVay2;
    data["SotienVay2"] = this.sotienVay2;
    data["LyDoVay2"] = this.lyDoVay2;
    data["ThoiDiemTatToan2"] = this.thoiDiemTatToan2;
    data["BienPhapThongNhat2"] = this.bienPhapThongNhat2;
    data["ThanhVienThuocDien"] = this.thanhVienThuocDien;
    data["MaSoHoNgheo"] = this.maSoHoNgheo;
    data["HoTenChuHo"] = this.hoTenChuHo;
    data["SoTienGuiTietKiemMoiKy"] = this.soTienGuiTietKiemMoiKy;
    data["TietKiemBatBuocXinRut"] = this.tietKiemBatBuocXinRut;
    data["TietKiemTuNguyenXinRut"] = this.tietKiemTuNguyenXinRut;
    data["TietKiemLinhHoatXinRut"] = this.tietKiemLinhHoatXinRut;
    data["ThoiDiemRut"] = this.thoiDiemRut;
    data["MucVayBoSung"] = this.mucVayBoSung;
    data["MucDichVayBoSung"] = this.mucDichVayBoSung;
    data["NgayVayBoSung"] = this.ngayVayBoSung;
    data["GhiChu"] = this.ghiChu;
    data["SoTienDuyetChovay"] = this.soTienDuyetChovay;
    data["TietKiemDinhHuong"] = this.tietKiemDinhHuong;
    data["MucDichVay"] = this.mucDichVay;
    data["DuyetChovayNgay"] = this.duyetChovayNgay;
    data["DaCapNhatVaoHoSoChovay"] = this.daCapNhatVaoHoSoChovay;
    return data;
  }

  factory SurveyInfoHistory.fromMap(Map<String, dynamic> json) => new SurveyInfoHistory(
        ngayXuatDanhSach: json["ngayXuatDanhSach"],
        masoCanBoKhaoSat: json["masoCanBoKhaoSat"],
        chinhanhId: json["chinhanhId"],
        cumId: json["cumId"],
        thanhvienId: json["thanhvienId"],
        tinhTrangHonNhan: json["tinhTrangHonNhan"],
        trinhDoHocVan: json["trinhDoHocVan"],
        khuVuc: json["khuVuc"],
        lanvay: json["lanvay"],
        nguoiTraloiKhaoSat: json["nguoiTraloiKhaoSat"],
        songuoiTrongHo: json["songuoiTrongHo"],
        songuoiCoviecLam: json["songuoiCoviecLam"],
        dientichDatTrong: json["dientichDatTrong"],
        giaTriVatNuoi: json["giaTriVatNuoi"],
        dungCuLaoDong: json["dungCuLaoDong"],
        phuongTienDiLai: json["phuongTienDiLai"],
        taiSanSinhHoat: json["taiSanSinhHoat"],
        quyenSoHuuNha: json["quyenSoHuuNha"],
        hemTruocNha: json["hemTruocNha"],
        maiNha: json["maiNha"],
        tuongNha: json["tuongNha"],
        nenNha: json["nenNha"],
        dienTichNhaTinhTren1Nguoi: json["dienTichNhaTinhTren1Nguoi"],
        dien: json["dien"],
        nuoc: json["nuoc"],
        mucDichSudungVon: json["mucDichSudungVon"],
        soTienCanThiet: json["soTienCanThiet"],
        soTienThanhVienDaCo: json["soTienThanhVienDaCo"],
        soTienCanVay: json["soTienCanVay"],
        thoiDiemSuDungVonvay: json["thoiDiemSuDungVonvay"],
        tongVonDauTu: json["tongVonDauTu"],
        thuNhapRongHangThang: json["thuNhapRongHangThang"],
        thuNhapCuaVoChong: json["thuNhapCuaVoChong"],
        thuNhapCuaCacCon: json["thuNhapCuaCacCon"],
        thuNhapKhac: json["thuNhapKhac"],
        tongChiPhiCuaThanhvien: json["tongChiPhiCuaThanhvien"],
        chiPhiDienNuoc: json["chiPhiDienNuoc"],
        chiPhiAnUong: json["chiPhiAnUong"],
        chiPhiHocTap: json["chiPhiHocTap"],
        chiPhiKhac: json["chiPhiKhac"],
        chiTraTienVayHangThang: json["chiTraTienVayHangThang"],
        tichLuyTangThemHangThang: json["tichLuyTangThemHangThang"],
        nguonVay1: json["nguonVay1"],
        sotienVay1: json["sotienVay1"],
        lyDoVay1: json["lyDoVay1"],
        thoiDiemTatToan1: json["thoiDiemTatToan1"],
        bienPhapThongNhat1: json["bienPhapThongNhat1"],
        nguonVay2: json["nguonVay2"],
        sotienVay2: json["sotienVay2"],
        lyDoVay2: json["lyDoVay2"],
        thoiDiemTatToan2: json["thoiDiemTatToan2"],
        bienPhapThongNhat2: json["bienPhapThongNhat2"],
        thanhVienThuocDien: json["thanhVienThuocDien"],
        maSoHoNgheo: json["maSoHoNgheo"],
        hoTenChuHo: json["hoTenChuHo"],
        soTienGuiTietKiemMoiKy: json["soTienGuiTietKiemMoiKy"],
        tietKiemBatBuocXinRut: json["tietKiemBatBuocXinRut"],
        tietKiemTuNguyenXinRut: json["tietKiemTuNguyenXinRut"],
        tietKiemLinhHoatXinRut: json["tietKiemLinhHoatXinRut"],
        thoiDiemRut: json["thoiDiemRut"],
        mucVayBoSung: json["mucVayBoSung"],
        mucDichVayBoSung: json["mucDichVayBoSung"],
        ngayVayBoSung: json["ngayVayBoSung"],
        ghiChu: json["ghiChu"],
        soTienDuyetChovay: json["soTienDuyetChovay"],
        tietKiemDinhHuong: json["tietKiemDinhHuong"],
        mucDichVay: json["mucDichVay"],
        duyetChovayNgay: json["duyetChovayNgay"],
        daCapNhatVaoHoSoChovay: json["daCapNhatVaoHoSoChovay"],
      );

}