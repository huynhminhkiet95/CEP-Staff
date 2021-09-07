class AddressGoogleMaps {
  int id;
  String addressLine;
  String subThoroughfare;
  String coordinates;
  String searchDate;

  AddressGoogleMaps(
      {this.id,
      this.addressLine,
      this.subThoroughfare,
      this.coordinates,
      this.searchDate});

  AddressGoogleMaps.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["addressLine"] is String) this.addressLine = json["addressLine"];
    if (json["subThoroughfare"] is String)
      this.subThoroughfare = json["subThoroughfare"];
    if (json["coordinates"] is String) this.coordinates = json["coordinates"];
    if (json["searchDate"] is String) this.searchDate = json["searchDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["addressLine"] = this.addressLine;
    data["subThoroughfare"] = this.subThoroughfare;
    data["coordinates"] = this.coordinates;
    data["searchDate"] = this.searchDate;
    return data;
  }

  factory AddressGoogleMaps.fromMap(Map<String, dynamic> json) =>
      new AddressGoogleMaps(
        id: json["id"],
        addressLine: json["addressLine"],
        subThoroughfare: json["subThoroughfare"],
        coordinates: json["coordinates"],
        searchDate: json["searchDate"],
      );
}
