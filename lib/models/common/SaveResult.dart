class SaveResult {
  String message;
  bool isSuccess;
  int valueReturn;

  SaveResult({this.message, this.isSuccess, this.valueReturn});

  factory SaveResult.fromJson(Map<String, dynamic> json) {
    return SaveResult(
      message: json["Message"] as String,
      isSuccess: json["IsSuccess"] as bool,
      valueReturn: int.parse(json["ValueReturn"].toString()),
    );
  }
}
