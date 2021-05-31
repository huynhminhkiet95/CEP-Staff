class GlobalRememberUser {
  String _userName;
  String _password;
  bool _isRemember;

  String get getUserName => _userName;

  set setUserName(String value) => _userName = value;

  String get getPassword => _password;

  set setPassword(String value) => _password = value;

  bool get getIsRemember => _isRemember;

  set setIsRemember(bool value) => _isRemember = value;

  static final GlobalRememberUser _translations =
      new GlobalRememberUser._internal();

  factory GlobalRememberUser() {
    return _translations;
  }

  GlobalRememberUser._internal();
}

GlobalRememberUser globalRememberUser = new GlobalRememberUser();
