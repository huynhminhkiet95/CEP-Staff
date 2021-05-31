import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/models/download_data/survey_info.dart';
import 'package:qr_code_demo/ui/screens/survey/listofsurveymembers.dart';
import 'package:flutter/material.dart';

abstract class SurveyEvent extends BlocEvent {
  SurveyEvent();
}

class LoadSurveyEvent extends SurveyEvent {
  LoadSurveyEvent() : super();
}

class SearchSurveyEvent extends SurveyEvent {
  final String cumID;
  final String ngayXuatDanhSach;
  SearchSurveyEvent(this.cumID, this.ngayXuatDanhSach) : super();
}

class UpdateSurveyEvent extends SurveyEvent {
  final SurveyInfo surveyInfo;
  final BuildContext context;
  UpdateSurveyEvent(this.surveyInfo, this.context) : super();
}

class UpdateSurveyToServerEvent extends SurveyEvent {
  final List<CheckBoxSurvey> listCheckBox;
  final BuildContext context;
  UpdateSurveyToServerEvent(this.listCheckBox, this.context) : super();
}

class InsertNewCommunityDevelopment extends SurveyEvent {
  final List<KhachHang> listKhachHang;
  final BuildContext context;
  InsertNewCommunityDevelopment(this.context, this.listKhachHang);
}
