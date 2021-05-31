class ContainerAndSealNo {
  int wOTaskId;
  String userId;
  String cNTRNo;
  String sealNo;

  Map toJson() {
    Map map = new Map();
    map["WOTaskId"] = wOTaskId;
    map["UserId"] = userId;
    map["CNTRNo"] = cNTRNo;
    map["SealNo"] = sealNo;
    return map;
  }

  ContainerAndSealNo();
}