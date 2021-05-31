mixin ServiceName {
  static const String Get_ValidateUser = "api/authentication/validateuser";
  static const String Get_Token = "api/NhanVien/Login";
  static const String GetUserInfo = "api/NhanVien/GetUsers?UserName=%s";
  static const String GetUserRoles = "api/NhanVien/GetUserRoles?UserName=%s";
  static const String GetSurveyInfo = "api/NhanVien/LayThongTinKhaoSat";
  static const String GetSurveyInfoHistory = "api/NhanVien/LayLichSuKhaoSatChoTBDD";
  static const String GetComboBoxValueChoTBD = "api/NhanVien/GetComboBoxValueChoTBĐ";
  static const String GetDataCommunityDevelopment = "api/NhanVien/XuatPTCDXuongDiDong";
  static const String UpdateSurveyInfo = "api/NhanVien/CapNhatThongTinKhaoSat";
  static const String UpdateCommunityDevelopmentInfo = "api/NhanVien/CapNhatPhatTrienCongDong";
  static const String GetCurrentVersion = "api/NhanVien/GetVersion_Staff";

  static const String Get_UserProfile = "api/authentication/userprofile/";
  static const String Get_TodoBookings = "api/etp/booking/gettodobooking";
  
  static const String Get_Notifications = "api/GetMessage/";
  static const String Get_TotalNotifications = "api/CountMessageByUser/";
  static const String Update_Notifications = "api/UpdateMsgStatus";
  static const String Delete_Notifications = "api/DeleteMessage/";
  
  
  static const String SaveImage = "api/document/saveimage";
  static const String GetDocuments = "api/document/getdocuments";
  static const String DeleteDocument = "api/document/deletedocument";
}
