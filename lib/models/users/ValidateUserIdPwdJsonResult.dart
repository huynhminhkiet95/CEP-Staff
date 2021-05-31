class UserInfoPwdJsonResult {
  //String token;
  //String nextCloudToken;
  //StaffInfo staffInfo;
  SystemInfo systemInfo;

  UserInfoPwdJsonResult({this.systemInfo});

  factory UserInfoPwdJsonResult.fromJson(Map<String, dynamic> jsondata) {
    // var _staffInfo = new StaffInfo();
    // _staffInfo = StaffInfo.fromJson(jsondata);
     var _systemInfo = new SystemInfo();
    _systemInfo = SystemInfo.fromJson(jsondata);

    return UserInfoPwdJsonResult(systemInfo: _systemInfo);
  }
}



class StaffInfo {
  String staffName;
  int staffId;
  String fleetdesc;

  StaffInfo({this.staffName, this.staffId, this.fleetdesc});

  factory StaffInfo.fromJson(Map<String, dynamic> json) {
    return StaffInfo(
      staffId: json['payload']['staffID'] as int,
      staffName: json['payload']['staffName'] as String ?? '',
      fleetdesc: json['payload']['fleet_Desc'] as String ?? '',
    );
  }
}

class SystemInfo {
  String systemId;
  String systemName;
  String notificationUrl;
  String inspectionUrl;

  SystemInfo({this.systemId, this.systemName, this.notificationUrl, this.inspectionUrl});

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      systemId: json['payload']['systemInfo']['systemId'] as String ?? '',
      systemName: json['payload']['systemInfo']['systemName'] as String ?? '',
      notificationUrl: json['payload']['systemInfo']['notificationUrl'] as String ?? '',
      inspectionUrl: json['payload']['systemInfo']['inspectionUrl'] as String ?? '',
    );
  }
}
