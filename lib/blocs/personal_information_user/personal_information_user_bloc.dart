import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/community_development/community_development_state.dart';
import 'package:qr_code_demo/blocs/personal_information_user/personal_information_user_state.dart';
import 'package:qr_code_demo/config/status_code.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/global_variables/global_teamID.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'personal_information_user_event.dart';

class PersonalInformationUserBloc extends BlocEventStateBase<
    PersonalInformationUserEvent, PersonalInformationUserState> {
  final SharePreferenceService sharePreferenceService;
  final CommonService commonService;

  PersonalInformationUserBloc(this.sharePreferenceService, this.commonService)
      : super(initialState: PersonalInformationUserState.init());

  BehaviorSubject<List<KhachHang>> _getPersonalInformationUserController =
      BehaviorSubject<List<KhachHang>>();
  Stream<List<KhachHang>> get getPersonalInformationUserStream =>
      _getPersonalInformationUserController;

  @override
  void dispose() {
    _getPersonalInformationUserController?.close();
    super.dispose();
  }

  @override
  Stream<PersonalInformationUserState> eventHandler(
      PersonalInformationUserEvent event,
      PersonalInformationUserState state) async* {
    if (event is UpdatePersonalInformationUserEvent) {
      yield PersonalInformationUserState.updateLoading(true);
      var response =
          await commonService.updateInfoCustomer(event.updateInformationUser);
      if (response.statusCode == StatusCodeConstants.OK) {
        var jsonBody = json.decode(response.body);
        if (jsonBody["isSuccessed"]) {
          if (jsonBody["data"] != null || !jsonBody["data"].isEmpty) {
            Fluttertoast.showToast(
              msg: "Cập nhật thành công !",
              timeInSecForIos: 10,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
              backgroundColor: Colors.green[600].withOpacity(0.9),
              textColor: Colors.white,
            );
          }
          yield PersonalInformationUserState.updateLoading(false);
        }
      } else {
        yield PersonalInformationUserState.updateLoading(false);
        Fluttertoast.showToast(
          msg: allTranslations.text("ServerNotFound"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          backgroundColor: Colors.red[300].withOpacity(0.7),
          textColor: Colors.white,
        );
      }
      yield PersonalInformationUserState.updateLoading(false);
    }
  }
}
