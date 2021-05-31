class RememberUser {
  
  String  _userName= "";
  String _password = "";
  bool _isRemember = false;

   String get getUserName => _userName;
   set setUserName(String userName ) => _userName = userName;

   String get getPassword => _password;
   set setPassword(String password ) => _password = password;

   
   bool get getIsRemember => _isRemember;
   set setIsRemember(bool isRemember ) => _isRemember = isRemember;

}