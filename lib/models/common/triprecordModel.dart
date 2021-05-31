class TriprecordModel {
   int id;
   String route;
   String memo;


  TriprecordModel({this.id, this.route, this.memo});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'route': route,
      'memo': memo,
    };
  }

  factory TriprecordModel.fromJson(Map<String, dynamic> json) =>
      new TriprecordModel(
        id: json["id"] as int,
        route: json["route"],
        memo: json["memo"],
      );
}
