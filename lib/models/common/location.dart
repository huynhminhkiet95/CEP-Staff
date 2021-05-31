class Location {
  String locCode;
  String locDesc;
  String locType;
  String zoneCode;

  Location({this.locCode, this.locDesc, this.locType, this.zoneCode});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locCode: json["LocCode"] as String,
      locDesc: json["LocDesc"] as String,
      locType: json["LocType"] as String,
      zoneCode: json["ZoneCode"] as String,
    );
  }
}
