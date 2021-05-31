class StdCode {
  String codeId;
  String codeType;
  String codeDesc;

  StdCode({this.codeId, this.codeType, this.codeDesc});

  factory StdCode.fromJson(Map<String, dynamic> json) {
    return StdCode(
      codeId: json["CodeID"] as String,
      codeType: json["CodeType"] as String,
      codeDesc: json["CodeDesc"] as String,
    );
  }
}
