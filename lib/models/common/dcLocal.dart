class DcLocal {
  String branchCode;
  String dCCode;
  String dCDesc;

  DcLocal({this.branchCode, this.dCCode, this.dCDesc});

  factory DcLocal.fromJson(Map<String, dynamic> json) {
    return DcLocal(
      branchCode: json["BranchCode"] as String,
      dCCode: json["DCCode"] as String,
      dCDesc: json["DCDesc"] as String,
    );
  }
}
