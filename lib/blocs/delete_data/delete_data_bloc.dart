// import 'dart:async';
// import 'dart:core';

// import 'package:qr_code_demo/GlobalTranslations.dart';
// import 'package:qr_code_demo/GlobalUser.dart';
// import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
// import 'package:qr_code_demo/config/status_code.dart';
// import 'package:qr_code_demo/database/DBProvider.dart';
// import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
// import 'package:qr_code_demo/models/download_data/historysearchsurvey.dart';
// import 'package:qr_code_demo/models/download_data/survey_info.dart';
// import 'package:qr_code_demo/models/download_data/survey_info_history.dart';
// import 'package:qr_code_demo/models/survey/survey_result.dart';
// import 'package:qr_code_demo/services/commonService.dart';
// import 'package:qr_code_demo/services/sharePreference.dart';
// import 'package:qr_code_demo/blocs/survey/survey_state.dart';
// import 'package:qr_code_demo/blocs/survey/survey_event.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rxdart/rxdart.dart';
// import 'dart:convert';

import 'dart:async';

import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/delete_data/delete_data_event.dart';
import 'package:qr_code_demo/blocs/delete_data/delete_data_state.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/models/download_data/historysearchsurvey.dart';
import 'package:qr_code_demo/models/download_data/survey_info.dart';
import 'package:qr_code_demo/models/download_data/survey_info_history.dart';
import 'package:qr_code_demo/models/survey/survey_result.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class DeleteDataBloc
    extends BlocEventStateBase<DeleteDataEvent, DeleteDataState> {
  final SharePreferenceService sharePreferenceService;
  final CommonService commonService;

  DeleteDataBloc(this.sharePreferenceService, this.commonService)
      : super(initialState: DeleteDataState.init());

  // BehaviorSubject<List<SurveyInfo>> _getSurveyController =
  //     BehaviorSubject<List<SurveyInfo>>();
  // Stream<List<SurveyInfo>> get getSurveys => _getSurveyController;

  // BehaviorSubject<List<HistorySearchSurvey>> _getHistorySurveyController =
  //     BehaviorSubject<List<HistorySearchSurvey>>();
  // Stream<List<HistorySearchSurvey>> get getHistorySurvey => _getHistorySurveyController;

  // BehaviorSubject<List<ComboboxModel>> _getComboboxController =
  //     BehaviorSubject<List<ComboboxModel>>();
  // Stream<List<ComboboxModel>> get getCombobox => _getComboboxController;

  BehaviorSubject<SurveyStream> _getSurveyStreamController =
      BehaviorSubject<SurveyStream>();
  Stream<SurveyStream> get getSurveyStream => _getSurveyStreamController;

  BehaviorSubject<List<KhachHang>> _getCommunityDevelopmentController =
      BehaviorSubject<List<KhachHang>>();
  Stream<List<KhachHang>> get getCommunityDevelopmentStream =>
      _getCommunityDevelopmentController;

  BehaviorSubject<List<String>> _getListTeamIDCommunityDevelopmentController =
      BehaviorSubject<List<String>>();
  Stream<List<String>> get getListTeamIDCommunityDevelopmentStream =>
      _getListTeamIDCommunityDevelopmentController;

  @override
  void dispose() {
    _getSurveyStreamController?.close();
    _getCommunityDevelopmentController?.close();
    _getListTeamIDCommunityDevelopmentController?.close();
    super.dispose();
  }

  @override
  Stream<DeleteDataState> eventHandler(
      DeleteDataEvent event, DeleteDataState state) async* {
    if (event is LoadSurveyEvent) {
      SurveyStream surveyStream = new SurveyStream();
      HistorySearchSurvey historySearch;
      yield DeleteDataState.updateLoading(true);
      List<HistorySearchSurvey> listHistorySearch =
          await DBProvider.db.getAllHistorySearchKhaoSat();

      if (listHistorySearch.length > 0) {
        if (globalUser.getCumId == null) {
          historySearch = listHistorySearch.last;
        } else {
          var historySearch1 = listHistorySearch
              .where((e) => e.cumID == globalUser.getCumId)
              .toList();
          if (historySearch1.length > 0) {
            historySearch = historySearch1.first;
          }
        }

        if (historySearch != null) {
          surveyStream.cumID = globalUser.getCumId == null
              ? listHistorySearch.last.cumID
              : historySearch.cumID;
          surveyStream.ngayXuatDS = globalUser.getCumId == null
              ? listHistorySearch.last.ngayXuatDanhSach
              : historySearch.ngayXuatDanhSach;
        }
      }

      List<SurveyInfo> listSurvey = await DBProvider.db.getAllKhaoSat();
      List<SurveyInfoHistory> listSurveyInfoHistory =
          await DBProvider.db.getAllLichSuKhaoSat();
      surveyStream.listHistorySearch = listHistorySearch;
      surveyStream.listSurvey = listSurvey
          .where((e) => e.idHistoryKhaoSat == historySearch?.id ?? 0)
          .toList();
      surveyStream.listSurveyInfoHistory = listSurveyInfoHistory;

      globalUser.setListSurveyGlobal = listSurvey;
      _getSurveyStreamController.sink.add(surveyStream);
      yield DeleteDataState.updateLoading(false);
    }
    if (event is SearchSurveyEvent) {
      SurveyStream surveyStream = new SurveyStream();
      String date = event.ngayXuatDanhSach;

      yield DeleteDataState.updateLoading(true);
      List<HistorySearchSurvey> listHistorySearch =
          await DBProvider.db.getAllHistorySearchKhaoSat();
      if (event.ngayXuatDanhSach == null) {
        date = listHistorySearch
            .where((e) => e.cumID == event.cumID)
            .first
            .ngayXuatDanhSach;
      }

      HistorySearchSurvey historySearch = listHistorySearch
          .where((e) => e.cumID == event.cumID && e.ngayXuatDanhSach == date)
          .first;
      List<SurveyInfo> listSurvey = await DBProvider.db.getAllKhaoSat();
      List<SurveyInfoHistory> listSurveyInfoHistory =
          await DBProvider.db.getAllLichSuKhaoSat();
      surveyStream.listHistorySearch = listHistorySearch;
      surveyStream.listSurvey = listSurvey
          .where((e) => e.idHistoryKhaoSat == historySearch.id)
          .toList();
      surveyStream.listSurveyInfoHistory = listSurveyInfoHistory;
      surveyStream.cumID = event.cumID;
      surveyStream.ngayXuatDS = date;
      globalUser.setListSurveyGlobal = listSurvey;
      _getSurveyStreamController.sink.add(surveyStream);

      this.sharePreferenceService.saveCumId(event.cumID);
      yield DeleteDataState.updateLoading(false);
    }
    if (event is DeleteSurveyEvent) {
      yield DeleteDataState.updateLoading(true);

      List<SurveyInfo> listSurveyByHistorySearch;
      List<SurveyInfo> listSurvey;
      HistorySearchSurvey historySearch;
      List<HistorySearchSurvey> listHistorySearch;
      var listCheckBox = event.listCheckBox
          .where((e) => e.status == true)
          .map((e) => e.id)
          .toList();
      listHistorySearch = await DBProvider.db.getAllHistorySearchKhaoSat();
      historySearch = listHistorySearch
          .where((e) =>
              e.cumID == event.cumID && e.ngayXuatDanhSach == event.ngayXuatDS)
          .first;
      listSurvey = await DBProvider.db.getAllKhaoSat();
      listSurveyByHistorySearch = listSurvey
          .where((e) => e.idHistoryKhaoSat == historySearch.id)
          .toList();
      if (listCheckBox.length == listSurveyByHistorySearch.length) {
        //remove all inclue historysearch and survey
        await DBProvider.db.deleteKhaoSatByIdHistorySearch(historySearch.id);
        this.sharePreferenceService.saveCumId(null);
      } else {
        //remove survey only
        for (var id in listCheckBox) {
          await DBProvider.db.deleteKhaoSatById(id);
        }
      }

      Timer(Duration(milliseconds: 1000), () {
        Fluttertoast.showToast(
          msg: allTranslations.text("RemoveSurveyInfoSuccessfully"),
          timeInSecForIos: 10,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          backgroundColor: Colors.green[600].withOpacity(0.9),
          textColor: Colors.white,
        );
        reloadData();
      });

      await showResultMessage().timeout(Duration(seconds: 2), onTimeout: () {
        print('0 timed out');
        return false;
      });
      yield DeleteDataState.updateLoading(false);
    }
    if (event is LoadCommunityDevelopmentEvent) {
      yield DeleteDataState.updateLoading(true);
      List<KhachHang> listKhachHang;
      if (globalUser.getCumIdOfCommunityDevelopment != null) {
        listKhachHang = await DBProvider.db.getCommunityDevelopmentByCum(
            globalUser.getUserInfo.chiNhanhID,
            globalUser.getUserInfo.masoql,
            globalUser.getCumIdOfCommunityDevelopment);
      }
      List<String> listTeamID =
          await DBProvider.db.getListTeamIDCommunityDevelopment();
      _getCommunityDevelopmentController.sink.add(listKhachHang);

      _getListTeamIDCommunityDevelopmentController.sink.add(listTeamID);
      yield DeleteDataState.updateLoading(false);
    }
    if (event is SearchCommunityDevelopmentEvent) {
      yield DeleteDataState.updateLoading(true);
      List<KhachHang> listKhachHang;
      listKhachHang = await DBProvider.db.getCommunityDevelopmentByCum(
          globalUser.getUserInfo.chiNhanhID,
          globalUser.getUserInfo.masoql,
          event.cumID);
      this.sharePreferenceService.saveCumIdOfCommunityDevelopment(event.cumID);
      _getCommunityDevelopmentController.sink.add(listKhachHang);

      yield DeleteDataState.updateLoading(false);
    }
    if (event is DeleteCommunityDevelopmentEvent) {
      yield DeleteDataState.updateLoading(true);
      var listCheckBox = event.listCheckBox
          .where((e) => e.status == true)
          .map((e) => e.id)
          .toList();

      for (var item in listCheckBox) {
        await DBProvider.db.deleteCommunityDevelopmentById(item);
      }

      Timer(Duration(milliseconds: 1000), () {
        Fluttertoast.showToast(
          msg: allTranslations.text("RemoveSurveyInfoSuccessfully"),
          timeInSecForIos: 10,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          backgroundColor: Colors.green[600].withOpacity(0.9),
          textColor: Colors.white,
        );
        reloadDataCommunityDevelopment();
      });
      await showResultMessage().timeout(Duration(seconds: 2), onTimeout: () {
        print('0 timed out');
        return false;
      });
      yield DeleteDataState.updateLoading(false);
    }
  }

  reloadDataCommunityDevelopment() async {
    List<String> listTeamID =
        await DBProvider.db.getListTeamIDCommunityDevelopment();

    this.sharePreferenceService.saveCumIdOfCommunityDevelopment(
        listTeamID == null || listTeamID.length == 0 ? "" : listTeamID.first);
    List<KhachHang> listKhachHang;
    if (globalUser.getCumIdOfCommunityDevelopment != null) {
      listKhachHang = await DBProvider.db.getCommunityDevelopmentByCum(
          globalUser.getUserInfo.chiNhanhID,
          globalUser.getUserInfo.masoql,
          globalUser.getCumIdOfCommunityDevelopment);
    }

    _getCommunityDevelopmentController.sink.add(listKhachHang);

    _getListTeamIDCommunityDevelopmentController.sink.add(listTeamID);
  }

  reloadData() async {
    SurveyStream surveyStream = new SurveyStream();
    HistorySearchSurvey historySearch;

    List<HistorySearchSurvey> listHistorySearch =
        await DBProvider.db.getAllHistorySearchKhaoSat();

    if (listHistorySearch.length > 0) {
      if (globalUser.getCumId == null) {
        historySearch = listHistorySearch.last;
      } else {
        var historySearch1 = listHistorySearch
            .where((e) => e.cumID == globalUser.getCumId)
            .toList();
        if (historySearch1.length > 0) {
          historySearch = historySearch1.first;
        }
      }

      if (historySearch != null) {
        surveyStream.cumID = globalUser.getCumId == null
            ? listHistorySearch.last.cumID
            : historySearch.cumID;
        surveyStream.ngayXuatDS = globalUser.getCumId == null
            ? listHistorySearch.last.ngayXuatDanhSach
            : historySearch.ngayXuatDanhSach;
      }
    }

    List<SurveyInfo> listSurvey = await DBProvider.db.getAllKhaoSat();
    List<SurveyInfoHistory> listSurveyInfoHistory =
        await DBProvider.db.getAllLichSuKhaoSat();
    surveyStream.listHistorySearch = listHistorySearch;
    surveyStream.listSurvey = listSurvey
        .where((e) => e.idHistoryKhaoSat == historySearch?.id ?? 0)
        .toList();
    surveyStream.listSurveyInfoHistory = listSurveyInfoHistory;

    globalUser.setListSurveyGlobal = listSurvey;
    _getSurveyStreamController.sink.add(surveyStream);
  }
}

Future<bool> showResultMessage() async {
  await Future.delayed(Duration(milliseconds: 1000), () {
    Fluttertoast.showToast(
      msg: allTranslations.text("RemoveSurveyInfoSuccessfully"),
      timeInSecForIos: 10,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.green[600].withOpacity(0.9),
      textColor: Colors.white,
    );
  });
  return true;
}
