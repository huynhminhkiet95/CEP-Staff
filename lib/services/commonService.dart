import 'dart:io';
import 'package:qr_code_demo/dtos/datalogin.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/models/download_data/survey_info.dart';
import 'package:http/http.dart';
import 'package:qr_code_demo/models/personal_information_user/update_information_user.dart';
import 'package:sprintf/sprintf.dart';
import 'package:qr_code_demo/dtos/UserLogin.dart';
import 'package:qr_code_demo/httpProvider/HttpProviders.dart';
import 'package:qr_code_demo/services/service_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonService {
  final HttpBase _httpBase;
  CommonService(this._httpBase);

  Future<Response> getUser(UserLogin userInfo) {
    return _httpBase.httpPostToken(
        ServiceName.Get_ValidateUser.toString(), userInfo.toJson());
  }

  Future<Response> getToken(DataLogin datalogin) {
    return _httpBase.postRequest(
        ServiceName.Get_Token.toString(), datalogin.toJson());
    //return _httpBase.postRequestTest(ServiceName.Get_Token.toString(), datalogin.toJson());
  }

  Future<Response> getGetUser(String userName) {
    return _httpBase
        .httpGetToken(sprintf(ServiceName.GetUserInfo.toString(), [userName]));
  }

  Future<Response> getUserRoles(String userName) {
    return _httpBase
        .httpGetToken(sprintf(ServiceName.GetUserRoles.toString(), [userName]));
  }

  Future<Response> getUserProfile(int id) {
    var url = ServiceName.Get_UserProfile.toString() + id.toString();
    return _httpBase.httpGetToken(url);
  }

  Future<Response> getCurrentVersion() {
    var url = ServiceName.GetCurrentVersion.toString();
    return _httpBase.httpGet(url);
  }

  Future<Response> getNotifications(
      String userId, String sourceType, String messageType) {
    var url = ServiceName.Get_Notifications.toString() +
        "$userId/$sourceType/$messageType";
    return _httpBase.httpGetHub(url);
  }

  Future<Response> countNotifications(String userId, String sourceType) {
    var url =
        ServiceName.Get_TotalNotifications.toString() + "$userId/$sourceType";
    return _httpBase.httpGetHub(url);
  }

  // Future<Response> updateNotifications(
  //     String userId, String reqIds, String status) {
  //   Map map = new Map();
  //   map["Username"] = userId;
  //   map["ReqIds"] = reqIds;
  //   map["FinalStatusMessage"] = status;
  //   var url = sprintf(ServiceName.Update_Notifications.toString(),
  //       [globalUser.getDefaultSubsidiary, '']);
  //   return _httpBase.httpPostHub(url, map);
  // }

  // Future<Response> deleteNotifications(String strReqIds) {
  //   Map map = new Map();
  //   var url = sprintf(ServiceName.Delete_Notifications.toString() + strReqIds,
  //       [globalUser.getDefaultSubsidiary, '']);
  //   return _httpBase.httpPostHubNoBody(url, map);
  // }

  // Future<StreamedResponse> saveImage(File file, int itemId) {
  //   return _httpBase.httpPostOpenalpr(file, itemId);
  // }

  Future<dynamic> saveImage(File file) {
    //return _httpBase.uploadImage1(file);
    return _httpBase.httpPostDocument(file);
  }

  Future<Response> getTestApiLocal(File file) {
    return _httpBase.getTestApiLocal();
  }

  Future<Response> downloadDataSurvey(
      int chiNhanhID, String cumID, String ngayxuatDS, String masoql) {
    Map map = new Map();
    map["chiNhanhID"] = chiNhanhID;
    map["cumID"] = cumID;
    map["ngayxuatDanhSach"] = ngayxuatDS;
    map["masoql"] = masoql;
    return _httpBase.httpPostToken(ServiceName.GetSurveyInfo.toString(), map);
  }

  Future<Response> downloadDataSurveyHistoryForTBDD(
      int chiNhanhID, String cumID, String ngayxuatDS, String masoql) {
    Map map = new Map();
    map["chiNhanhID"] = chiNhanhID;
    map["cumID"] = cumID;
    map["ngayxuatDanhSach"] = ngayxuatDS;
    map["masoql"] = masoql;
    return _httpBase.httpPostToken(
        ServiceName.GetSurveyInfoHistory.toString(), map);
  }

  Future<Response> downloadDataComboBox() {
    return _httpBase
        .httpPostTokenNotBody(ServiceName.GetComboBoxValueChoTBD.toString());
  }

  Future<Response> downloadDataCommunityDevelopment(
      int chiNhanhID, String cumID, String masoql) {
    Map map = new Map();
    map["chinhanhid"] = chiNhanhID;
    map["cumID"] = cumID;
    map["masoql"] = masoql;
    return _httpBase.httpPostToken(
        ServiceName.GetDataCommunityDevelopment.toString(), map);
  }

  Future<Response> updateSurveyInfo(List<SurveyInfo> body) {
    return _httpBase.httpPostToken(
        ServiceName.UpdateSurveyInfo.toString(), body);
  }

  Future<Response> updateCommunityDevelopment(List<KhachHang> body) {
    return _httpBase.httpPostToken(
        ServiceName.UpdateCommunityDevelopmentInfo.toString(), body);
  }

  Future<Response> updateInfoCustomer(UpdateInformationUser body) {
    return _httpBase.httpPostToken(
        ServiceName.UpdateInfoCustomer.toString(), body);
  }
}
