class ContactLocal {
  String contactCode;
  String contactName;

  ContactLocal({this.contactCode, this.contactName});

  factory ContactLocal.fromJson(Map<String, dynamic> json) {
    return ContactLocal(
      contactCode: json["ContactCode"] as String,
      contactName: json["ContactName"] as String,
    );
  }
}
