class LastestMile {
  int lastestMile;
  int lastRead;

  LastestMile({this.lastestMile, this.lastRead});

  factory LastestMile.fromJson(Map<String, dynamic> json) {
    return LastestMile(
      lastestMile: json["lastestMile"] as int,
      lastRead: json["lastRead"] as int,
    );
  }
}
