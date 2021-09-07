import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/community_development/community_development_state.dart';
import 'package:qr_code_demo/config/status_code.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'community_development_event.dart';

class CommunityDevelopmentBloc extends BlocEventStateBase<
    CommunityDevelopmentEvent, CommunityDevelopmentState> {
  final SharePreferenceService sharePreferenceService;
  final CommonService commonService;

  CommunityDevelopmentBloc(this.sharePreferenceService, this.commonService)
      : super(initialState: CommunityDevelopmentState.init());

  BehaviorSubject<List<KhachHang>> _getCommunityDevelopmentController =
      BehaviorSubject<List<KhachHang>>();
  Stream<List<KhachHang>> get getCommunityDevelopmentStream =>
      _getCommunityDevelopmentController;

  @override
  void dispose() {
    _getCommunityDevelopmentController?.close();
    super.dispose();
  }

  @override
  Stream<CommunityDevelopmentState> eventHandler(
      CommunityDevelopmentEvent event, CommunityDevelopmentState state) async* {
    if (event is LoadCommunityDevelopmentEvent) {
      yield CommunityDevelopmentState.updateLoading(true);

      List<KhachHang> listKhachHang;
      if (globalUser.getCumIdOfCommunityDevelopment != null) {
        listKhachHang = await DBProvider.db.getCommunityDevelopmentByCum(
            globalUser.getUserInfo.chiNhanhID,
            globalUser.getUserInfo.masoql,
            globalUser.getCumIdOfCommunityDevelopment);
      }
      _getCommunityDevelopmentController.sink.add(listKhachHang);
      yield CommunityDevelopmentState.updateLoading(false);
    }
    if (event is SearchCommunityDevelopmentEvent) {
      yield CommunityDevelopmentState.updateLoading(true);
      List<KhachHang> listKhachHang;
      if (event.cumID != null) {
        listKhachHang = await DBProvider.db.getCommunityDevelopmentByCum(
            globalUser.getUserInfo.chiNhanhID,
            globalUser.getUserInfo.masoql,
            event.cumID);
        if (listKhachHang.length > 0) {
          this
              .sharePreferenceService
              .saveCumIdOfCommunityDevelopment(event.cumID);
        }
      }
      _getCommunityDevelopmentController.sink.add(listKhachHang);

      yield CommunityDevelopmentState.updateLoading(false);
    }

    if (event is UpdateCommunityDevelopmentEvent) {
      yield CommunityDevelopmentState.updateLoading(true);
      int rs = await DBProvider.db.updateCommunityDevelopment(event.khachHang);

      Timer(Duration(milliseconds: 1000), () {
        if (rs > 0) {
          Navigator.pop(event.context, true);
          Fluttertoast.showToast(
            msg: allTranslations
                .text("UpdateCommunityDevelopmentInfoSuccessfully"),
            timeInSecForIos: 10,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
            backgroundColor: Colors.green[600].withOpacity(0.9),
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(
              msg: allTranslations.text("Savefail"),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
      yield CommunityDevelopmentState.updateLoading(false);
    }
    if (event is UpdateCommunityDevelopmentToServerEvent) {
      yield CommunityDevelopmentState.updateLoading(true);
      await DBProvider.db.updateCommunityDevelopment(event.khachHang);

      List<KhachHang> listKhachHang;
      List<KhachHang> listBody = new List<KhachHang>();
      listKhachHang = await DBProvider.db.getCommunityDevelopmentByCum(
          globalUser.getUserInfo.chiNhanhID,
          globalUser.getUserInfo.masoql,
          globalUser.getCumIdOfCommunityDevelopment);
      listBody =
          listKhachHang.where((e) => e.id == event.khachHang.id).toList();

      var response = await commonService.updateCommunityDevelopment(listBody);
      if (response.statusCode == StatusCodeConstants.OK) {
        var jsonBody = json.decode(response.body);
        if (jsonBody["isSuccessed"]) {
          if (jsonBody["data"] != null || !jsonBody["data"].isEmpty) {
            Fluttertoast.showToast(
              msg: jsonBody["message"],
              timeInSecForIos: 10,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
              backgroundColor: Colors.green[600].withOpacity(0.9),
              textColor: Colors.white,
            );
            Navigator.pop(event.context, true);
          }
          yield CommunityDevelopmentState.updateLoadingSaveData(false);
        }
      } else {
        yield CommunityDevelopmentState.updateLoadingSaveData(false);
        Fluttertoast.showToast(
          msg: allTranslations.text("ServerNotFound"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          backgroundColor: Colors.red[300].withOpacity(0.7),
          textColor: Colors.white,
        );
      }

      yield CommunityDevelopmentState.updateLoading(false);
    }
  }
}
