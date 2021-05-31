class GetFleetMile {
  String lastestMile;
  String lastRead;

  GetFleetMile({this.lastestMile, this.lastRead});

  factory GetFleetMile.fromJson(Map<String, dynamic> json) {
    return GetFleetMile(
      lastestMile: json["LastestMile"] as String,
      lastRead: json["LastRead"] as String,
    );
  }
}
