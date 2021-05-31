class UserRole {
  bool salary;
  bool hPqlnlhc;
  bool banTgd;
  bool administrator;
  bool td;
  bool giaoDich;
  bool ktv;
  bool tq;
  bool kiemSoat2;
  bool hHs;
  bool hPtckt;
  bool gdcn;
  bool provisional;
  bool ptcd;
  bool hPcntt;
  bool dataBase;
  bool tpkt;
  bool chiNhanh;
  bool kiemSoat;
  bool thionline;
  bool tttd;
  bool hPqltd;
  bool hPhlptd;
  bool tptd;
  bool upLoad;
  bool hPktnb;

  UserRole(
      {this.salary,
      this.hPqlnlhc,
      this.banTgd,
      this.administrator,
      this.td,
      this.giaoDich,
      this.ktv,
      this.tq,
      this.kiemSoat2,
      this.hHs,
      this.hPtckt,
      this.gdcn,
      this.provisional,
      this.ptcd,
      this.hPcntt,
      this.dataBase,
      this.tpkt,
      this.chiNhanh,
      this.kiemSoat,
      this.thionline,
      this.tttd,
      this.hPqltd,
      this.hPhlptd,
      this.tptd,
      this.upLoad,
      this.hPktnb});

  UserRole.fromJson(Map<String, dynamic> json) {
    if (json["Salary"] is bool) this.salary = json["Salary"];
    if (json["H-PQLNLHC"] is bool) this.hPqlnlhc = json["H-PQLNLHC"];
    if (json["BanTGD"] is bool) this.banTgd = json["BanTGD"];
    if (json["Administrator"] is bool)
      this.administrator = json["Administrator"];
    if (json["TD"] is bool) this.td = json["TD"];
    if (json["GiaoDich"] is bool) this.giaoDich = json["GiaoDich"];
    if (json["KTV"] is bool) this.ktv = json["KTV"];
    if (json["TQ"] is bool) this.tq = json["TQ"];
    if (json["KiemSoat2"] is bool) this.kiemSoat2 = json["KiemSoat2"];
    if (json["H-HS"] is bool) this.hHs = json["H-HS"];
    if (json["H-PTCKT"] is bool) this.hPtckt = json["H-PTCKT"];
    if (json["GDCN"] is bool) this.gdcn = json["GDCN"];
    if (json["Provisional"] is bool) this.provisional = json["Provisional"];
    if (json["PTCD"] is bool) this.ptcd = json["PTCD"];
    if (json["H-PCNTT"] is bool) this.hPcntt = json["H-PCNTT"];
    if (json["DataBase"] is bool) this.dataBase = json["DataBase"];
    if (json["TPKT"] is bool) this.tpkt = json["TPKT"];
    if (json["ChiNhanh"] is bool) this.chiNhanh = json["ChiNhanh"];
    if (json["KiemSoat"] is bool) this.kiemSoat = json["KiemSoat"];
    if (json["THIONLINE"] is bool) this.thionline = json["THIONLINE"];
    if (json["TTTD"] is bool) this.tttd = json["TTTD"];
    if (json["H-PQLTD"] is bool) this.hPqltd = json["H-PQLTD"];
    if (json["H-PHLPTD"] is bool) this.hPhlptd = json["H-PHLPTD"];
    if (json["TPTD"] is bool) this.tptd = json["TPTD"];
    if (json["UpLoad"] is bool) this.upLoad = json["UpLoad"];
    if (json["H-PKTNB"] is bool) this.hPktnb = json["H-PKTNB"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Salary"] = this.salary;
    data["H-PQLNLHC"] = this.hPqlnlhc;
    data["BanTGD"] = this.banTgd;
    data["Administrator"] = this.administrator;
    data["TD"] = this.td;
    data["GiaoDich"] = this.giaoDich;
    data["KTV"] = this.ktv;
    data["TQ"] = this.tq;
    data["KiemSoat2"] = this.kiemSoat2;
    data["H-HS"] = this.hHs;
    data["H-PTCKT"] = this.hPtckt;
    data["GDCN"] = this.gdcn;
    data["Provisional"] = this.provisional;
    data["PTCD"] = this.ptcd;
    data["H-PCNTT"] = this.hPcntt;
    data["DataBase"] = this.dataBase;
    data["TPKT"] = this.tpkt;
    data["ChiNhanh"] = this.chiNhanh;
    data["KiemSoat"] = this.kiemSoat;
    data["THIONLINE"] = this.thionline;
    data["TTTD"] = this.tttd;
    data["H-PQLTD"] = this.hPqltd;
    data["H-PHLPTD"] = this.hPhlptd;
    data["TPTD"] = this.tptd;
    data["UpLoad"] = this.upLoad;
    data["H-PKTNB"] = this.hPktnb;
    return data;
  }

  factory UserRole.fromMap(Map<String, dynamic> json) => new UserRole(
        salary: json["salary"] == 1 ? true : false,
        hPqlnlhc: json["hPqlnlhc"] == 1 ? true : false,
        banTgd: json["banTgd"] == 1 ? true : false,
        administrator: json["administrator"] == 1 ? true : false,
        td: json["td"] == 1 ? true : false,
        giaoDich: json["giaoDich"] == 1 ? true : false,
        ktv: json["ktv"] == 1 ? true : false,
        tq: json["tq"] == 1 ? true : false,
        kiemSoat2: json["kiemSoat2"] == 1 ? true : false,
        hHs: json["hHs"] == 1 ? true : false,
        hPtckt: json["hPtckt"] == 1 ? true : false,
        gdcn: json["gdcn"] == 1 ? true : false,
        provisional: json["provisional"] == 1 ? true : false,
        ptcd: json["ptcd"] == 1 ? true : false,
        hPcntt: json["hPcntt"] == 1 ? true : false,
        dataBase: json["dataBase"] == 1 ? true : false,
        tpkt: json["tpkt"] == 1 ? true : false,
        chiNhanh: json["chiNhanh"] == 1 ? true : false,
        kiemSoat: json["kiemSoat"] == 1 ? true : false,
        thionline: json["thionline"] == 1 ? true : false,
        tttd: json["tttd"] == 1 ? true : false,
        hPqltd: json["hPqltd"] == 1 ? true : false,
        hPhlptd: json["hPhlptd"] == 1 ? true : false,
        tptd: json["tptd"] == 1 ? true : false,
        upLoad: json["upLoad"] == 1 ? true : false,
        hPktnb: json["hPktnb"] == 1 ? true : false,
      );
}
