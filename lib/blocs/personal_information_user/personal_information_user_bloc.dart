import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/personal_information_user/personal_information_user_state.dart';
import 'package:qr_code_demo/config/formatdate.dart';
import 'package:qr_code_demo/config/status_code.dart';
import 'package:qr_code_demo/config/toast_result_message.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/models/personal_information_user/customer_info.dart';
import 'package:qr_code_demo/models/personal_information_user/update_information_user.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'personal_information_user_event.dart';
import 'package:qr_code_demo/enum/typeInfor.dart';

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

  BehaviorSubject<bool> _getIsUpdateSuccessController = BehaviorSubject<bool>();
  Stream<bool> get getIsUpdateSuccessStream => _getIsUpdateSuccessController;

  @override
  void dispose() {
    _getPersonalInformationUserController?.close();
    _getIsUpdateSuccessController?.close();
    super.dispose();
  }

  @override
  Stream<PersonalInformationUserState> eventHandler(
      PersonalInformationUserEvent event,
      PersonalInformationUserState state) async* {
    if (event is UpdatePersonalInformationUserEvent) {
      yield PersonalInformationUserState.updateLoading(true);
      UpdateInformationUser updateInformationUser = event.updateInformationUser;
      _getIsUpdateSuccessController.sink.add(false);
      for (var i = 0; i < event.imageFiles.length; i++) {
        var resImage = await commonService.saveImage(event.imageFiles[i]);
        if (resImage != null) {
          updateInformationUser.urlHinhanh[i].urlHinhanh = resImage.data;
        }
      }
      if (updateInformationUser.urlHinhanh.first.urlHinhanh == "") {
        // if save image succesffully
        ToastResultMessage.error(allTranslations.text("SaveImageFailed"));
      } else {
        var response =
            await commonService.updateInfoCustomer(updateInformationUser);
        if (response.statusCode == StatusCodeConstants.OK) {
          var jsonBody = json.decode(response.body);
          if (jsonBody["isSuccessed"]) {
            _getIsUpdateSuccessController.sink.add(true);
            if (jsonBody["data"] != null || !jsonBody["data"].isEmpty) {
              var changeInfoCardID = updateInformationUser.tblThongtinthaydoi
                  .where((e) => e.loaithongtinId == TypeInfo.idNO.index)
                  .first;
              var changeInfoFullName = updateInformationUser.tblThongtinthaydoi
                  .where((e) => e.loaithongtinId == TypeInfo.fullName.index)
                  .first;
              var changeInfoSex = updateInformationUser.tblThongtinthaydoi
                  .where((e) => e.loaithongtinId == TypeInfo.sex.index)
                  .first;
              var changeInfoDOB = updateInformationUser.tblThongtinthaydoi
                  .where((e) => e.loaithongtinId == TypeInfo.dob.index)
                  .first;
              var changeInfoNativePlace = updateInformationUser
                  .tblThongtinthaydoi
                  .where((e) =>
                      e.loaithongtinId == TypeInfo.addressPermanent.index)
                  .first;

              CustomerInfo customerInfo = new CustomerInfo(
                customerCode: updateInformationUser.makhachhang,
                branchId: updateInformationUser.chinhanhid,
                coordinates: updateInformationUser.latiLongTude,
                currentResidence: '',
                newId: changeInfoCardID.giatriMoi,
                oldId: changeInfoCardID.giatriCu,
                fullName: changeInfoFullName.giatriMoi,
                sex: changeInfoSex.giatriMoi,
                dob: changeInfoDOB.giatriMoi,
                nativePlace: changeInfoNativePlace.giatriMoi,
                dateOfIssue: changeInfoCardID.ngaycap,
                frontImage: updateInformationUser.urlHinhanh[0].urlHinhanh,
                backImage: updateInformationUser.urlHinhanh[1].urlHinhanh,
                createDate: FormatDateConstants.convertDateTimeToStringT(
                    DateTime.now()),
                updateDate: FormatDateConstants.convertDateTimeToStringT(
                    DateTime.now()),
              );

              await DBProvider.db.newCustomerInfo(customerInfo);
              ToastResultMessage.success(allTranslations.text("Updatesuccess"));
            }
            yield PersonalInformationUserState.updateLoading(false);
          }
        } else {
          yield PersonalInformationUserState.updateLoading(false);
          ToastResultMessage.error(allTranslations.text("ServerNotFound"));
        }
      }

      yield PersonalInformationUserState.updateLoading(false);
    }
  }
}
