class ActivityModel {
  int id;
  int type;
  String pickupPlace;
  String returnPlace;
  String createdate;
  String activity;
  String userId;

  ActivityModel(
      {this.id,
      this.type,
      this.pickupPlace,
      this.returnPlace,
      this.createdate,
      this.userId,
      this.activity});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'pickupPlace': pickupPlace,
      'returnPlace': returnPlace,
      'createdate': createdate,
      'userId': userId,
      'activity': activity,
    };
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      new ActivityModel(
        id: json["id"] as int,
        type: json["type"],
        pickupPlace: json["pickupPlace"],
        returnPlace: json["returnPlace"],
        createdate: json["createdate"],
        userId: json["userId"],
        activity: json["activity"],
      );
}
