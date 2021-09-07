class CustomerInfo {
  int id;
  String customerCode;
  int branchId;
  String coordinates;
  String currentResidence;
  String newId;
  String oldId;
  String fullName;
  String sex;
  String dob;
  String nativePlace;
  String dateOfIssue;
  String frontImage;
  String backImage;
  String createDate;
  String updateDate;
  CustomerInfo(
      {this.id,
      this.customerCode,
      this.branchId,
      this.coordinates,
      this.currentResidence,
      this.newId,
      this.oldId,
      this.fullName,
      this.sex,
      this.dob,
      this.nativePlace,
      this.dateOfIssue,
      this.frontImage,
      this.backImage,
      this.createDate,
      this.updateDate});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["customerCode"] is String)
      this.customerCode = json["customerCode"];
    if (json["branchId"] is int) this.branchId = json["branchId"];
    if (json["coordinates"] is String) this.coordinates = json["coordinates"];
    if (json["currentResidence"] is String)
      this.currentResidence = json["currentResidence"];
    if (json["newId"] is String) this.newId = json["newId"];
    if (json["oldId"] is String) this.oldId = json["oldId"];
    if (json["fullName"] is String) this.fullName = json["fullName"];
    if (json["sex"] is String) this.sex = json["sex"];
    if (json["dob"] is String) this.dob = json["dob"];
    if (json["nativePlace"] is String) this.nativePlace = json["nativePlace"];
    if (json["dateOfIssue"] is String) this.dateOfIssue = json["dateOfIssue"];
    if (json["frontImage"] is String) this.frontImage = json["frontImage"];
    if (json["backImage"] is String) this.backImage = json["backImage"];
    if (json["createDate"] is String) this.createDate = json["createDate"];
    if (json["updateDate"] is String) this.updateDate = json["updateDate"];
  }
}
