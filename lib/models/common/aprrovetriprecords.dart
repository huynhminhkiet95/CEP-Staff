class Aprrovetriprecords {
  int trId;
  String fleetDesc;
  String staffName;
  String customerName;
  String fleetModelDesc;
  int lastestMile;
  int lastRead;
  int startTime;
  int endTime;
  int startMile;
  int endMile;
  int mileRun;
  String routeMemo;
  int tollFee;
  int parkingFee;
  String tripMemo;
  int createDate;
  String bookNo;
  String approved;
  int approvalDate;
  int approveUser;
  String isApprovel;
  int endUserVerifyDate;
  String lat;
  String lon;

  Aprrovetriprecords({
    this.trId,
    this.fleetDesc,
    this.staffName,
    this.fleetModelDesc,
    this.lastestMile,
    this.lastRead,
    this.startTime,
    this.endTime,
    this.startMile,
    this.endMile,
    this.mileRun,
    this.routeMemo,
    this.tollFee,
    this.parkingFee,
    this.tripMemo,
    this.createDate,
    this.bookNo,
    this.approved,
    this.approvalDate,
    this.approveUser,
    this.isApprovel,
    this.endUserVerifyDate,
    this.customerName,
    this.lat,
    this.lon
  });

  factory Aprrovetriprecords.fromJson(Map<String, dynamic> json) {
    return Aprrovetriprecords(
      trId: json["trId"] as int,
      fleetDesc: json["fleet_Desc"] as String ?? '',
      staffName: json["staffName"] as String ?? '',
      customerName: json["customerName"] as String ?? '',
      fleetModelDesc: json["fleetModelDesc"] as String ?? '',
      lastestMile: json["lastestMile"] as int,
      lastRead: json["lastRead"] as int,
      startTime: json["startTime"] as int,
      startMile: json["startMile"] as int,
      endTime: json["endTime"] as int,
      endMile: json["endMile"] as int,
      mileRun: json["mileRun"] as int,
      routeMemo: json["routeMemo"] as String ?? '',
      tollFee: json["tollFee"] as int,
      parkingFee: json["parkingFee"] as int,
      tripMemo: json["tripMemo"] as String,
      createDate: json["createDate"] as int,
      bookNo: json["bookNo"] as String ?? '',
      approved: json["approved"] as String ?? '',
      approvalDate: json["approvalDate"] as int,
      approveUser: json["approveUser"] as int ,
      isApprovel: json["isApprovel"] as String ?? '',
      endUserVerifyDate: json["endUserVerifyDate"] as int,
      lat: json["lat"] as String ?? "0",
      lon: json["lon"] as String ?? "0",
    );
  }
}
