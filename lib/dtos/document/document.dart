class DocumentInfo {
  int docNo ;
  String fileName ;
  String docRefType;
  String refNoType;
  String refNoValue;
  int createUser;
  int updateUser;
  String userId;
  String filePath;
  String fileType;
  double fileSize;

  // public int? docNo { get; set; }
  //       public string fileName { get; set; }
  //       public string docRefType { get; set; }
  //       public string refNoType { get; set; }
  //       public string refNoValue { get; set; }
  //       public int createUser { get; set; }
  //       public int? updateUser { get; set; }
  //       public string userId { get; set; }
  //       public string filePath { get; set; }
  //       public string fileType { get; set; }
  //       public float? fileSize { get; set; }



  Map toJson() {
    Map map = new Map();
    map["docNo"] = docNo ?? null;
    map["fileName"] = fileName ??"";
    map["docRefType"] = docRefType ?? "";
    map["refNoType"] = refNoType ?? "";
    map["refNoValue"] = refNoValue ?? "";
    map["createUser"] = createUser  ?? 0;
    map["updateUser"] = updateUser ?? null;
    map["userId"] = userId ?? "";
    map["filePath"] = filePath == null ? "":filePath;
    map["fileType"] = fileType ?? "";
    map["fileSize"] = fileSize ?? null;
    
    return map;
  }
}