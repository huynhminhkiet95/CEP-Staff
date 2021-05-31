class GlobleDriverProfile {
  String _driverName;
  String _phoneNumber;
  String _icNumber;
  String _licenseNumber;
  String _fleet;
  String _avatar;

  String get getDriverName => _driverName;

  set setDriverName(String value) => _driverName = value;

  String get getPhoneNumber => _phoneNumber;

  set setPhoneNumber(String value) => _phoneNumber = value;

  String get geticNumber => _icNumber;

  set seticNumber(String value) => _icNumber = value;

  String get getlicenseNumber => _licenseNumber;

  set setlicenseNumber(String value) => _licenseNumber = value;

  String get getfleet => _fleet;

  set setfleet(String value) => _fleet = value;

   String get getavatar => _avatar;

  set setavatar(String value) => _avatar = value;

  static final GlobleDriverProfile driverGlobal =
      new GlobleDriverProfile._internal();

  factory GlobleDriverProfile() {
    return driverGlobal;
  }

  GlobleDriverProfile._internal();
}

GlobleDriverProfile globalDriverProfile = new GlobleDriverProfile();
