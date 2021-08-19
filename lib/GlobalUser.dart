import 'package:qr_code_demo/models/download_data/survey_info.dart';
import 'package:qr_code_demo/models/users/user_role.dart';
import 'package:qr_code_demo/models/historyscreen/history_screen.dart';

import 'models/download_data/comboboxmodel.dart';
import 'models/users/user_info.dart';

class GlobalUser {
  // String _defaultCenter;
  // String _defaultClient;
  // String _defaultSubsidiary;
  // String _defaultSystem;
  // String _subsidiaryId;
  // String _subsidiaryName;
  String _userName;
  String _password;
  bool _isAuthenLocal;
  String _rememberUserName;
  String _isRememberLogin;
  String _cumId;
  String _cumIdOfCommunityDevelopment;
  String _userId;
  String _defaultBranch;
  String _token;
  bool _isNotification;
  int _id;
  // int _staffId;
  // int _employeeId;
  // String _systemId;
  UserInfo _userInfo;
  UserRole _userRole;
  HistoryScreen _historyScreen;
  List<ComboboxModel> _comboboxModel;
  List<SurveyInfo> _surveyInfoGlobal;

  int get getId => _id;

  set setId(int value) => _id = value;

  // int get getStaffId => _staffId;

  // set setemployeeId(int value) => _employeeId = value;

  // int get getemployeeId => _employeeId;

  // set setStaffId(int value) => _staffId = value;

  String get getUserId => _userId;

  set setuserId(String value) => _userId = value;

  String get getUserName => _userName;

  set setUserName(String value) => _userName = value;

  String get getPassword => _password;

  set setPassword(String value) => _password = value;

  bool get getAuthenLocal => _isAuthenLocal;

  set setAuthenLocal(bool value) => _isAuthenLocal = value;

  String get getRememberUserName => _rememberUserName;

  set setRememberUserName(String value) => _rememberUserName = value;

  String get getIsRememberLogin => _isRememberLogin;

  set setIsRememberLogin(String value) => _isRememberLogin = value;

  String get getCumId => _cumId;

  set setCumId(String value) => _cumId = value;

  String get getCumIdOfCommunityDevelopment => _cumIdOfCommunityDevelopment;

  set setCumIdOfCommunityDevelopment(String value) =>
      _cumIdOfCommunityDevelopment = value;

  // String get getDefaultCenter => _defaultCenter;

  // set setDefaultCenter(String value) => _defaultCenter = value;

  // String get getDefaultClient => _defaultClient;

  // set setDefaultClient(String value) => _defaultClient = value;

  // String get getDefaultSubsidiary => _defaultSubsidiary;

  // set setdefaultSubsidiary(String value) => _defaultSubsidiary = value;

  // String get getDefaultSystem => _defaultSystem;

  // set setDefaultSystem(String value) => _defaultSystem = value;

  // String get getSubsidiaryId => _subsidiaryId;

  // set setSubsidiaryId(String value) => _subsidiaryId = value;

  // get getSubsidiaryName => _subsidiaryName;

  // set setSubsidiaryName(String value) => _subsidiaryName = value;

  String get getdefaultBranch => _defaultBranch;

  set setdefaultBranch(String value) => _defaultBranch = value;

  String get gettoken => _token;

  set settoken(String value) => _token = value;

  UserInfo get getUserInfo => _userInfo;

  set setUserInfo(UserInfo value) => _userInfo = value;

  UserRole get getUserRoles => _userRole;

  set setHistoryScreen(HistoryScreen value) => _historyScreen = value;

  HistoryScreen get getHistoryScreen => _historyScreen;

  set setListComboboxModel(List<ComboboxModel> value) => _comboboxModel = value;

  List<ComboboxModel> get getListComboboxModel => _comboboxModel;

  set setListSurveyGlobal(List<SurveyInfo> value) => _surveyInfoGlobal = value;

  List<SurveyInfo> get getListSurveyGlobal => _surveyInfoGlobal;

  set setUserRoles(UserRole value) => _userRole = value;

  bool get getNotification => _isNotification;

  set setNotification(bool value) => _isNotification = value;

  // String get getSystemId => _systemId;

  // set setSystemId(String value) => _systemId = value;

  static final GlobalUser userGlobal = new GlobalUser._internal();

  factory GlobalUser() {
    return userGlobal;
  }

  GlobalUser._internal();
}

GlobalUser globalUser = new GlobalUser();
