import 'package:qr_code_demo/dtos/dtobase.dart';

class DataLogin extends BaseDto {
  String userName;
  String password;
  String key;
  bool rememberMe;

  DataLogin({this.userName, this.password, this.key, this.rememberMe});

  @override
  Map toJson() {
    Map map = new Map();
    map["userName"] = userName;
    map["password"] = password;
    map["key"] = key;
    return map;
  }
}
