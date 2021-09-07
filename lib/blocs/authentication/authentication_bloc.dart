import 'dart:async';
import 'dart:convert';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_event.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_state.dart';
import 'package:qr_code_demo/config/status_code.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/dtos/datalogin.dart';
import 'package:qr_code_demo/globalRememberUser.dart';
import 'package:qr_code_demo/globalServer.dart';
import 'package:qr_code_demo/models/common/version_staff.dart';
import 'package:qr_code_demo/models/users/user_info.dart';
import 'package:qr_code_demo/models/users/user_role.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc
    extends BlocEventStateBase<AuthenticationEvent, AuthenticationState> {
  final CommonService _commonService;
  final SharePreferenceService _sharePreferenceService;

  AuthenticationBloc(this._commonService, this._sharePreferenceService)
      : super(
            initialState: AuthenticationState.defaultAuthenticationState(
                globalRememberUser.getIsRemember ?? false,
                globalRememberUser.getUserName,
                globalRememberUser.getPassword,
                globalServer.getServerCode));

  BehaviorSubject<bool> _getIsNewVersionController = BehaviorSubject<bool>();
  Stream<bool> get getIsNewVersionStream => _getIsNewVersionController;

  @override
  void dispose() async {
    await _getIsNewVersionController.drain();
    _getIsNewVersionController?.close();
    super.dispose();
  }

  // @mustCallSuper
  // void dispose() async{
  //   await _eventSubject.drain();
  //   _eventSubject.close();
  //   await _stateSubject.drain();
  //   _stateSubject.close();
  // }

  @override
  Stream<AuthenticationState> eventHandler(
      AuthenticationEvent event, AuthenticationState currentState) async* {
    if (event is AuthenticationEventLogin) {
      yield AuthenticationState.authenticating(currentState);

      /// khi khong co mang//

      // UserInfoPwdJsonResult userIdPwdJsonResult;
      // yield AuthenticationState.authenticated(
      //                   event.isRemember,
      //                   event.userName,
      //                   event.password,
      //                   currentState.serverCode,
      //                   userIdPwdJsonResult);
      ///

      // the network is ready to test

      var dataToken = new DataLogin(
        userName: event.userName,
        password: event.password,
      );

      var token = await this
          ._commonService
          .getToken(dataToken)
          .then((response) => response);
      if (token != null) {
        if (token.statusCode == StatusCodeConstants.OK) {
          var jsonBodyToken = json.decode(token.body);
          if (jsonBodyToken["isSuccessed"] == true) {
            if (jsonBodyToken["token"] != null) {
              this._sharePreferenceService.saveToken(jsonBodyToken["token"]);
              if (event.userName != globalUser.getUserName) {
                this._sharePreferenceService.saveAuthenLocal(false);
                this._sharePreferenceService.saveCumId(null);
              }

              this._sharePreferenceService.saveUserName(event.userName);
              this._sharePreferenceService.savePassword(event.password);

              if (event.isRemember == true) {
                this._sharePreferenceService.saveRememberUser(event.userName);
                this._sharePreferenceService.saveIsRemember("1");
              } else {
                this._sharePreferenceService.saveRememberUser(event.userName);
                this._sharePreferenceService.saveIsRemember("0");
              }
              List responses = await Future.wait(
                  [getUserInfo(event.userName), getUserRoles(event.userName)]);
              if (responses != null &&
                  (responses[0] is UserInfo || responses[0] != null) &&
                  (responses[1] is UserRole || responses[1] != null)) {
                await DBProvider.db.newUserInfo(responses[0]);
                await DBProvider.db.newUserRole(responses[1]);
                globalUser.setUserInfo = responses[0];
                globalUser.setUserRoles = responses[1];
                yield AuthenticationState.authenticated(event.isRemember,
                    event.userName, event.password, currentState.serverCode);
              }
            } else if (jsonBodyToken["message"] == "Tài khoản bị khóa") {
              yield AuthenticationState.failedByUser(currentState);
              Fluttertoast.showToast(
                msg: allTranslations.text("UserBlocked"),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red[300].withOpacity(0.7),
                textColor: Colors.white,
              );
            } else {
              yield AuthenticationState.failedByUser(currentState);
              Fluttertoast.showToast(
                msg: allTranslations.text("UserIsNotExist"),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red[300].withOpacity(0.7),
                textColor: Colors.white,
              );
            }
          } else {
            yield AuthenticationState.failedByUser(currentState);
            Fluttertoast.showToast(
              msg: allTranslations.text("UserIsNotExist"),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red[300].withOpacity(0.7),
              textColor: Colors.white,
            );
          }
        } else if (token.statusCode == StatusCodeConstants.BAD_REQUEST) {
          yield AuthenticationState.failedByUser(currentState);
          Fluttertoast.showToast(
            msg: allTranslations.text("ServerNotFound"),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
            backgroundColor: Colors.red[300].withOpacity(0.7),
            textColor: Colors.white,
          );
        }
      } else {
        yield AuthenticationState.failedByUser(currentState);
        Fluttertoast.showToast(
          msg: allTranslations.text("ServerNotFound"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          backgroundColor: Colors.red[300].withOpacity(0.7),
          textColor: Colors.white,
        );
      }
    }

    if (event is AuthenticationEventLogout) {
      globalUser.settoken = "";
      this._sharePreferenceService.saveToken("");
      if (currentState.isRemember) {
        yield AuthenticationState.notAuthenticated(currentState.userName,
            currentState.password, currentState.isRemember);
      } else {
        yield AuthenticationState.notAuthenticated("", "", false);
      }
    }
    if (event is LoadCurrentVersionEvent) {
      var response = await _commonService.getCurrentVersion();
      if (response != null &&
          response.statusCode == 200 &&
          response.body.isNotEmpty) {
        var dataJson = json.decode(response.body);
        if (dataJson['data'].isNotEmpty) {
          VersionStaff versionStaff = VersionStaff.fromJson(dataJson['data']);
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String buildNumber = packageInfo.buildNumber;
          if (int.parse(buildNumber) < versionStaff.maPhienBan) {
            _getIsNewVersionController.sink.add(true);
          } else {
            _getIsNewVersionController.sink.add(false);
          }
        }
      }
    }
  }

  Future<UserInfo> getUserInfo(String userName) async {
    UserInfo userInfoModel;
    try {
      var userInfo = await this
          ._commonService
          .getGetUser(userName)
          .then((response) => response);
      if (userInfo.statusCode == StatusCodeConstants.OK) {
        var jsonBodyUserInfo = json.decode(userInfo.body);
        if (jsonBodyUserInfo["isSuccessed"]) {
          var dataUserInfo = UserInfo.fromJson(
              jsonBodyUserInfo["data"] == null ||
                      jsonBodyUserInfo["data"].isEmpty
                  ? null
                  : jsonBodyUserInfo["data"].first);
          userInfoModel = dataUserInfo;
        }
      }
    } catch (e) {
      userInfoModel = null;
    }
    return userInfoModel;
  }

  Future<UserRole> getUserRoles(String userName) async {
    UserRole userRolesModel;
    try {
      var userRoles = await this
          ._commonService
          .getUserRoles(userName)
          .then((response) => response);
      if (userRoles.statusCode == StatusCodeConstants.OK) {
        var jsonBodyUserRoles = json.decode(userRoles.body);
        if (jsonBodyUserRoles["isSuccessed"]) {
          var dataUserRoles = UserRole.fromJson(
              jsonBodyUserRoles["data"] == null ||
                      jsonBodyUserRoles["data"].isEmpty
                  ? null
                  : jsonBodyUserRoles["data"].first);
          userRolesModel = dataUserRoles;
        }
      }
    } catch (e) {
      userRolesModel = null;
    }
    return userRolesModel;
  }
}
