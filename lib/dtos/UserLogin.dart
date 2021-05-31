import 'package:qr_code_demo/dtos/dtobase.dart';

class UserLogin extends BaseDto {
  String userName;
  String password;
  String iPAddress;
  String systemId;

  void setUserName(String userName) {
    this.userName = userName;
  }

  String getUserName() {
    return this.userName;
  }

  String getPassword() {
    return this.password;
  }

  void setPassword(String passWord) {
    this.password = passWord;
  }

  void setIp(String ip) {
    this.iPAddress = ip;
  }

  void setplatform(String platform) {
    this.password = platform;
  }

  String getsystemId() {
    return this.systemId;
  }

  UserLogin({this.userName, this.password, this.iPAddress, this.systemId});

  @override
  Map toJson() {
    Map map = new Map();
    map["UserName"] = userName;
    map["Password"] = password;
    map["IPAddress"] = iPAddress;
    map["SystemId"] = systemId;
    return map;
  }
}
