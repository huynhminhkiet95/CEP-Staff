class SurveyInfo {
  int id;
  String ngayXuatDanhSach;
  String ngayKhaoSat;
  String masoCanBoKhaoSat;
  int chinhanhId;
  int duanId;
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
  String tinhTrangNgheo;
  int daDuocDuyet;
  String username;
  String ngaycapnhat;
  dynamic masoCanBoKhaoSatPss;
  int sotienVayLantruoc;
  int thoiGianTaivay;
  int songayNoquahanCaonhat;
  int thoiGianKhaosatGannhat;
  String ngayTatToanDotvayTruoc;
  int batBuocKhaosat;
  int conNo;
  int dichVuSgb;
  bool moTheMoi; //bool
  int soTienDuyetChoVayCk;
  int gioiTinh;
  String cmnd;
  String ngaySinh;
  String diaChi;
  String thoigianthamgia;
  String hoVaTen;
  int statusCheckBox;
  int idHistoryKhaoSat;
  int moTheMoiBool;

  SurveyInfo(
      {this.id,
      this.ngayXuatDanhSach,
      this.ngayKhaoSat,
      this.masoCanBoKhaoSat,
      this.chinhanhId,
      this.duanId,
      this.cumId,
      this.thanhvienId,
      this.tinhTrangHonNhan,
      this.trinhDoHocVan,
      this.khuVuc,
      this.lanvay,
      this.nguoiTraloiKhaoSat,
      this.songuoiTrongHo,
      this.songuoiCoviecLam,
      this.dientichDatTrong,
      this.giaTriVatNuoi,
      this.dungCuLaoDong,
      this.phuongTienDiLai,
      this.taiSanSinhHoat,
      this.quyenSoHuuNha,
      this.hemTruocNha,
      this.maiNha,
      this.tuongNha,
      this.nenNha,
      this.dienTichNhaTinhTren1Nguoi,
      this.dien,
      this.nuoc,
      this.mucDichSudungVon,
      this.soTienCanThiet,
      this.soTienThanhVienDaCo,
      this.soTienCanVay,
      this.thoiDiemSuDungVonvay,
      this.tongVonDauTu,
      this.thuNhapRongHangThang,
      this.thuNhapCuaVoChong,
      this.thuNhapCuaCacCon,
      this.thuNhapKhac,
      this.tongChiPhiCuaThanhvien,
      this.chiPhiDienNuoc,
      this.chiPhiAnUong,
      this.chiPhiHocTap,
      this.chiPhiKhac,
      this.chiTraTienVayHangThang,
      this.tichLuyTangThemHangThang,
      this.nguonVay1,
      this.sotienVay1,
      this.lyDoVay1,
      this.thoiDiemTatToan1,
      this.bienPhapThongNhat1,
      this.nguonVay2,
      this.sotienVay2,
      this.lyDoVay2,
      this.thoiDiemTatToan2,
      this.bienPhapThongNhat2,
      this.thanhVienThuocDien,
      this.maSoHoNgheo,
      this.hoTenChuHo,
      this.soTienGuiTietKiemMoiKy,
      this.tietKiemBatBuocXinRut,
      this.tietKiemTuNguyenXinRut,
      this.tietKiemLinhHoatXinRut,
      this.thoiDiemRut,
      this.mucVayBoSung,
      this.mucDichVayBoSung,
      this.ngayVayBoSung,
      this.ghiChu,
      this.soTienDuyetChovay,
      this.tietKiemDinhHuong,
      this.mucDichVay,
      this.duyetChovayNgay,
      this.daCapNhatVaoHoSoChovay,
      this.tinhTrangNgheo,
      this.daDuocDuyet,
      this.username,
      this.ngaycapnhat,
      this.masoCanBoKhaoSatPss,
      this.sotienVayLantruoc,
      this.thoiGianTaivay,
      this.songayNoquahanCaonhat,
      this.thoiGianKhaosatGannhat,
      this.ngayTatToanDotvayTruoc,
      this.batBuocKhaosat,
      this.conNo,
      this.dichVuSgb,
      this.moTheMoi,
      this.soTienDuyetChoVayCk,
      this.gioiTinh,
      this.cmnd,
      this.ngaySinh,
      this.diaChi,
      this.thoigianthamgia,
      this.hoVaTen,
      this.statusCheckBox,
      this.idHistoryKhaoSat, this.moTheMoiBool});

  SurveyInfo.fromJson(Map<String, dynamic> json) {
    if (json["ID"] is int) this.id = json["ID"];
    if (json["NgayXuatDanhSach"] is String)
      this.ngayXuatDanhSach = json["NgayXuatDanhSach"].trim();
    if (json["NgayKhaoSat"] is String) this.ngayKhaoSat = json["NgayKhaoSat"].trim();
    if (json["MasoCanBoKhaoSat"] is String)
      this.masoCanBoKhaoSat = json["MasoCanBoKhaoSat"].trim();
    if (json["ChinhanhID"] is int) this.chinhanhId = json["ChinhanhID"];
    if (json["DuanID"] is int) this.duanId = json["DuanID"];
    if (json["CumID"] is String) this.cumId = json["CumID"].trim();
    if (json["ThanhvienID"] is String) this.thanhvienId = json["ThanhvienID"].trim();
    if (json["TinhTrangHonNhan"] is String)
      this.tinhTrangHonNhan = json["TinhTrangHonNhan"].trim();
    if (json["TrinhDoHocVan"] is String)
      this.trinhDoHocVan = json["TrinhDoHocVan"].trim();
    if (json["KhuVuc"] is int) this.khuVuc = json["KhuVuc"];
    if (json["Lanvay"] is int) this.lanvay = json["Lanvay"];
    if (json["NguoiTraloiKhaoSat"] is String)
      this.nguoiTraloiKhaoSat = json["NguoiTraloiKhaoSat"].trim();
    if (json["SonguoiTrongHo"] is int)
      this.songuoiTrongHo = json["SonguoiTrongHo"];
    if (json["SonguoiCoviecLam"] is int)
      this.songuoiCoviecLam = json["SonguoiCoviecLam"];
    if (json["DientichDatTrong"] is int)
      this.dientichDatTrong = json["DientichDatTrong"];
    if (json["GiaTriVatNuoi"] is int)
      this.giaTriVatNuoi = json["GiaTriVatNuoi"];
    if (json["DungCuLaoDong"] is int)
      this.dungCuLaoDong = json["DungCuLaoDong"];
    if (json["PhuongTienDiLai"] is int)
      this.phuongTienDiLai = json["PhuongTienDiLai"];
    if (json["TaiSanSinhHoat"] is int)
      this.taiSanSinhHoat = json["TaiSanSinhHoat"];
    if (json["QuyenSoHuuNha"] is String)
      this.quyenSoHuuNha = json["QuyenSoHuuNha"].trim();
    if (json["HemTruocNha"] is int) this.hemTruocNha = json["HemTruocNha"];
    if (json["MaiNha"] is String) this.maiNha = json["MaiNha"].trim();
    if (json["TuongNha"] is String) this.tuongNha = json["TuongNha"].trim();
    if (json["NenNha"] is String) this.nenNha = json["NenNha"].trim();
    if (json["DienTichNhaTinhTren1Nguoi"] is int)
      this.dienTichNhaTinhTren1Nguoi = json["DienTichNhaTinhTren1Nguoi"];
    if (json["Dien"] is String) this.dien = json["Dien"].trim();
    if (json["Nuoc"] is String) this.nuoc = json["Nuoc"].trim();
    if (json["MucDichSudungVon"] is String)
      this.mucDichSudungVon = json["MucDichSudungVon"].trim();
    if (json["SoTienCanThiet"] is int)
      this.soTienCanThiet = json["SoTienCanThiet"];
    if (json["SoTienThanhVienDaCo"] is int)
      this.soTienThanhVienDaCo = json["SoTienThanhVienDaCo"];
    if (json["SoTienCanVay"] is int) this.soTienCanVay = json["SoTienCanVay"];
    if (json["ThoiDiemSuDungVonvay"] is String)
      this.thoiDiemSuDungVonvay = json["ThoiDiemSuDungVonvay"].trim();
    if (json["TongVonDauTu"] is int) this.tongVonDauTu = json["TongVonDauTu"];
    if (json["ThuNhapRongHangThang"] is int)
      this.thuNhapRongHangThang = json["ThuNhapRongHangThang"];
    if (json["ThuNhapCuaVoChong"] is int)
      this.thuNhapCuaVoChong = json["ThuNhapCuaVoChong"];
    if (json["ThuNhapCuaCacCon"] is int)
      this.thuNhapCuaCacCon = json["ThuNhapCuaCacCon"];
    if (json["ThuNhapKhac"] is int) this.thuNhapKhac = json["ThuNhapKhac"];
    if (json["TongChiPhiCuaThanhvien"] is int)
      this.tongChiPhiCuaThanhvien = json["TongChiPhiCuaThanhvien"];
    if (json["ChiPhiDienNuoc"] is int)
      this.chiPhiDienNuoc = json["ChiPhiDienNuoc"];
    if (json["ChiPhiAnUong"] is int) this.chiPhiAnUong = json["ChiPhiAnUong"];
    if (json["ChiPhiHocTap"] is int) this.chiPhiHocTap = json["ChiPhiHocTap"];
    if (json["ChiPhiKhac"] is int) this.chiPhiKhac = json["ChiPhiKhac"];
    if (json["ChiTraTienVayHangThang"] is int)
      this.chiTraTienVayHangThang = json["ChiTraTienVayHangThang"];
    if (json["TichLuyTangThemHangThang"] is int)
      this.tichLuyTangThemHangThang = json["TichLuyTangThemHangThang"];
    if (json["NguonVay1"] is String) this.nguonVay1 = json["NguonVay1"].trim();
    if (json["SotienVay1"] is int) this.sotienVay1 = json["SotienVay1"];
    if (json["LyDoVay1"] is String) this.lyDoVay1 = json["LyDoVay1"].trim();
    if (json["ThoiDiemTatToan1"] is String)
      this.thoiDiemTatToan1 = json["ThoiDiemTatToan1"].trim();
    if (json["BienPhapThongNhat1"] is String)
      this.bienPhapThongNhat1 = json["BienPhapThongNhat1"].trim();
    if (json["NguonVay2"] is String) this.nguonVay2 = json["NguonVay2"].trim();
    if (json["SotienVay2"] is int) this.sotienVay2 = json["SotienVay2"];
    if (json["LyDoVay2"] is String) this.lyDoVay2 = json["LyDoVay2"].trim();
    if (json["ThoiDiemTatToan2"] is String)
      this.thoiDiemTatToan2 = json["ThoiDiemTatToan2"].trim();
    if (json["BienPhapThongNhat2"] is String)
      this.bienPhapThongNhat2 = json["BienPhapThongNhat2"].trim();
    if (json["ThanhVienThuocDien"] is String)
      this.thanhVienThuocDien = json["ThanhVienThuocDien"].trim();
    if (json["MaSoHoNgheo"] is String) this.maSoHoNgheo = json["MaSoHoNgheo"].trim();
    if (json["HoTenChuHo"] is String) this.hoTenChuHo = json["HoTenChuHo"].trim();
    if (json["SoTienGuiTietKiemMoiKy"] is int)
      this.soTienGuiTietKiemMoiKy = json["SoTienGuiTietKiemMoiKy"];
    if (json["TietKiemBatBuocXinRut"] is int)
      this.tietKiemBatBuocXinRut = json["TietKiemBatBuocXinRut"];
    if (json["TietKiemTuNguyenXinRut"] is int)
      this.tietKiemTuNguyenXinRut = json["TietKiemTuNguyenXinRut"];
    if (json["TietKiemLinhHoatXinRut"] is int)
      this.tietKiemLinhHoatXinRut = json["TietKiemLinhHoatXinRut"];
    if (json["ThoiDiemRut"] is String) this.thoiDiemRut = json["ThoiDiemRut"].trim();
    if (json["MucVayBoSung"] is int) this.mucVayBoSung = json["MucVayBoSung"];
    if (json["MucDichVayBoSung"] is String)
      this.mucDichVayBoSung = json["MucDichVayBoSung"].trim();
    if (json["NgayVayBoSung"] is String)
      this.ngayVayBoSung = json["NgayVayBoSung"];
    if (json["GhiChu"] is String) this.ghiChu = json["GhiChu"].trim();
    if (json["SoTienDuyetChovay"] is int)
      this.soTienDuyetChovay = json["SoTienDuyetChovay"];
    if (json["TietKiemDinhHuong"] is int)
      this.tietKiemDinhHuong = json["TietKiemDinhHuong"];
    if (json["MucDichVay"] is String) this.mucDichVay = json["MucDichVay"].trim();
    if (json["DuyetChovayNgay"] is String)
      this.duyetChovayNgay = json["DuyetChovayNgay"].trim();
    if (json["DaCapNhatVaoHoSoChovay"] is int)
      this.daCapNhatVaoHoSoChovay = json["DaCapNhatVaoHoSoChovay"];
    if (json["TinhTrangNgheo"] is String)
      this.tinhTrangNgheo = json["TinhTrangNgheo"].trim();
    if (json["DaDuocDuyet"] is int) this.daDuocDuyet = json["DaDuocDuyet"];
    if (json["Username"] is String) this.username = json["Username"].trim();
    if (json["Ngaycapnhat"] is String) this.ngaycapnhat = json["Ngaycapnhat"].trim();
    if (json["MasoCanBoKhaoSatPSS"] is String)// previous is dynamic
      this.masoCanBoKhaoSatPss = json["MasoCanBoKhaoSatPSS"];
    if (json["SotienVayLantruoc"] is int)
      this.sotienVayLantruoc = json["SotienVayLantruoc"];
    if (json["ThoiGianTaivay"] is int)
      this.thoiGianTaivay = json["ThoiGianTaivay"];
    if (json["SongayNoquahanCaonhat"] is int)
      this.songayNoquahanCaonhat = json["SongayNoquahanCaonhat"];
    if (json["ThoiGianKhaosatGannhat"] is int)
      this.thoiGianKhaosatGannhat = json["ThoiGianKhaosatGannhat"];
    if (json["NgayTatToanDotvayTruoc"] is String)
      this.ngayTatToanDotvayTruoc = json["NgayTatToanDotvayTruoc"].trim();
    if (json["BatBuocKhaosat"] is int)
      this.batBuocKhaosat = json["BatBuocKhaosat"];
    if (json["ConNo"] is int) this.conNo = json["ConNo"];
    if (json["DichVuSGB"] is int) this.dichVuSgb = json["DichVuSGB"];
    if (json["MoTheMoi"] is bool)
      this.moTheMoi = json["MoTheMoi"];
      this.moTheMoiBool = json["MoTheMoi"] == false ? 0 : 1;
    if (json["SoTienDuyetChoVayCK"] is int)
      this.soTienDuyetChoVayCk = json["SoTienDuyetChoVayCK"];
    if (json["GioiTinh"] is int) this.gioiTinh = json["GioiTinh"];
    if (json["cmnd"] is String) this.cmnd = json["cmnd"].trim();
    if (json["NgaySinh"] is String) this.ngaySinh = json["NgaySinh"].trim();
    if (json["DiaChi"] is String) this.diaChi = json["DiaChi"].trim();
    if (json["Thoigianthamgia"] is String)
      this.thoigianthamgia = json["Thoigianthamgia"].trim();
    if (json["HoVaTen"] is String) this.hoVaTen = json["HoVaTen"].trim();
    this.idHistoryKhaoSat = json["idHistoryKhaoSat"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["ngayXuatDanhSach"] = this.ngayXuatDanhSach;
    data["ngayKhaoSat"] = this.ngayKhaoSat;
    data["masoCanBoKhaoSat"] = this.masoCanBoKhaoSat;
    data["chinhanhID"] = this.chinhanhId;
    data["duanID"] = this.duanId;
    data["cumID"] = this.cumId;
    data["thanhvienID"] = this.thanhvienId;
    data["tinhTrangHonNhan"] = this.tinhTrangHonNhan;
    data["trinhDoHocVan"] = this.trinhDoHocVan;
    data["khuVuc"] = this.khuVuc;
    data["lanvay"] = this.lanvay;
    data["nguoiTraloiKhaoSat"] = this.nguoiTraloiKhaoSat;
    data["songuoiTrongHo"] = this.songuoiTrongHo;
    data["songuoiCoviecLam"] = this.songuoiCoviecLam;
    data["dientichDatTrong"] = this.dientichDatTrong;
    data["giaTriVatNuoi"] = this.giaTriVatNuoi;
    data["dungCuLaoDong"] = this.dungCuLaoDong;
    data["phuongTienDiLai"] = this.phuongTienDiLai;
    data["taiSanSinhHoat"] = this.taiSanSinhHoat;
    data["quyenSoHuuNha"] = this.quyenSoHuuNha;
    data["hemTruocNha"] = this.hemTruocNha;
    data["maiNha"] = this.maiNha;
    data["tuongNha"] = this.tuongNha;
    data["nenNha"] = this.nenNha;
    data["dienTichNhaTinhTren1Nguoi"] = this.dienTichNhaTinhTren1Nguoi;
    data["dien"] = this.dien;
    data["nuoc"] = this.nuoc;
    data["mucDichSudungVon"] = this.mucDichSudungVon;
    data["soTienCanThiet"] = this.soTienCanThiet;
    data["soTienThanhVienDaCo"] = this.soTienThanhVienDaCo;
    data["soTienCanVay"] = this.soTienCanVay;
    data["thoiDiemSuDungVonvay"] = this.thoiDiemSuDungVonvay;
    data["tongVonDauTu"] = this.tongVonDauTu;
    data["thuNhapRongHangThang"] = this.thuNhapRongHangThang;
    data["thuNhapCuaVoChong"] = this.thuNhapCuaVoChong;
    data["thuNhapCuaCacCon"] = this.thuNhapCuaCacCon;
    data["thuNhapKhac"] = this.thuNhapKhac;
    data["tongChiPhiCuaThanhvien"] = this.tongChiPhiCuaThanhvien;
    data["chiPhiDienNuoc"] = this.chiPhiDienNuoc;
    data["chiPhiAnUong"] = this.chiPhiAnUong;
    data["chiPhiHocTap"] = this.chiPhiHocTap;
    data["chiPhiKhac"] = this.chiPhiKhac;
    data["chiTraTienVayHangThang"] = this.chiTraTienVayHangThang;
    data["tichLuyTangThemHangThang"] = this.tichLuyTangThemHangThang;
    data["nguonVay1"] = this.nguonVay1;
    data["sotienVay1"] = this.sotienVay1;
    data["lyDoVay1"] = this.lyDoVay1;
    data["thoiDiemTatToan1"] = this.thoiDiemTatToan1;
    data["bienPhapThongNhat1"] = this.bienPhapThongNhat1;
    data["nguonVay2"] = this.nguonVay2;
    data["sotienVay2"] = this.sotienVay2;
    data["lyDoVay2"] = this.lyDoVay2;
    data["thoiDiemTatToan2"] = this.thoiDiemTatToan2;
    data["bienPhapThongNhat2"] = this.bienPhapThongNhat2;
    data["thanhVienThuocDien"] = this.thanhVienThuocDien;
    data["maSoHoNgheo"] = this.maSoHoNgheo;
    data["hoTenChuHo"] = this.hoTenChuHo;
    data["soTienGuiTietKiemMoiKy"] = this.soTienGuiTietKiemMoiKy;
    data["tietKiemBatBuocXinRut"] = this.tietKiemBatBuocXinRut;
    data["tietKiemTuNguyenXinRut"] = this.tietKiemTuNguyenXinRut;
    data["tietKiemLinhHoatXinRut"] = this.tietKiemLinhHoatXinRut;
    data["thoiDiemRut"] = this.thoiDiemRut;
    data["mucVayBoSung"] = this.mucVayBoSung;
    data["mucDichVayBoSung"] = this.mucDichVayBoSung;
    data["ngayVayBoSung"] =  (this.ngayVayBoSung == "null" || this.ngayVayBoSung.isEmpty) ? null : this.ngayVayBoSung;
    data["ghiChu"] = this.ghiChu;
    data["soTienDuyetChovay"] = this.soTienDuyetChovay;
    data["tietKiemDinhHuong"] = this.tietKiemDinhHuong;
    data["mucDichVay"] = this.mucDichVay;
    data["duyetChovayNgay"] =  this.duyetChovayNgay == "null" ? null : this.duyetChovayNgay;
    data["daCapNhatVaoHoSoChovay"] = this.daCapNhatVaoHoSoChovay;
    data["tinhTrangNgheo"] = this.tinhTrangNgheo;
    data["daDuocDuyet"] = this.daDuocDuyet;
    data["username"] = this.username;
    data["ngaycapnhat"] = this.ngaycapnhat;
    data["masoCanBoKhaoSatPSS"] = this.masoCanBoKhaoSatPss;
    data["sotienVayLantruoc"] = this.sotienVayLantruoc;
    data["thoiGianTaivay"] = this.thoiGianTaivay;
    data["songayNoquahanCaonhat"] = this.songayNoquahanCaonhat;
    data["thoiGianKhaosatGannhat"] = this.thoiGianKhaosatGannhat;
    data["ngayTatToanDotvayTruoc"] =(this.ngayTatToanDotvayTruoc == "null" || this.ngayTatToanDotvayTruoc.isEmpty) ? null : this.ngayTatToanDotvayTruoc;
    data["batBuocKhaosat"] = this.batBuocKhaosat;
    data["conNo"] = this.conNo;
    data["dichVuSGB"] = this.dichVuSgb;
    data["moTheMoi"] = this.moTheMoiBool == 1 ? true: false;
    data["soTienDuyetChoVayCK"] = this.soTienDuyetChoVayCk;
    data["gioiTinh"] = this.gioiTinh;
    data["cmnd"] = this.cmnd;
    data["ngaySinh"] = this.ngaySinh;
    data["diaChi"] = this.diaChi;
    data["thoigianthamgia"] = this.thoigianthamgia;
    data["hoVaTen"] = this.hoVaTen;
    return data;
  }

  factory SurveyInfo.fromMap(Map<String, dynamic> json) => new SurveyInfo(
        id: json["id"],
        ngayXuatDanhSach: json["ngayXuatDanhSach"],
        ngayKhaoSat: json["ngayKhaoSat"],
        masoCanBoKhaoSat: json["masoCanBoKhaoSat"],
        chinhanhId: json["chinhanhId"],
        duanId: json["duanId"],
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
        tinhTrangNgheo: json["tinhTrangNgheo"],
        daDuocDuyet: json["daDuocDuyet"],
        username: json["username"],
        ngaycapnhat: json["ngaycapnhat"],
        masoCanBoKhaoSatPss: json["masoCanBoKhaoSatPss"],
        sotienVayLantruoc: json["sotienVayLantruoc"],
        thoiGianTaivay: json["thoiGianTaivay"],
        songayNoquahanCaonhat: json["songayNoquahanCaonhat"],
        thoiGianKhaosatGannhat: json["thoiGianKhaosatGannhat"],
        ngayTatToanDotvayTruoc: json["ngayTatToanDotvayTruoc"],
        batBuocKhaosat: json["batBuocKhaosat"],
        conNo: json["conNo"],
        dichVuSgb: json["dichVuSgb"],
        moTheMoi: json["moTheMoi"] is bool,
        soTienDuyetChoVayCk: json["soTienDuyetChoVayCk"],
        gioiTinh: json["gioiTinh"],
        cmnd: json["cmnd"],
        ngaySinh: json["ngaySinh"],
        diaChi: json["diaChi"],
        thoigianthamgia: json["thoigianthamgia"],
        hoVaTen: json["hoVaTen"],
        statusCheckBox: json["statusCheckBox"],
        idHistoryKhaoSat: json["idHistoryKhaoSat"],
      );
}
