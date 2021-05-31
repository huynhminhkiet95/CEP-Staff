import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

abstract class DownloadDataEvent extends BlocEvent {
  DownloadDataEvent();
}

class DownloadDataSurveyEvent extends DownloadDataEvent {
  int chiNhanhID;
  String cumID;
  String ngayxuatDS;
  String masoql;
  DownloadDataSurveyEvent(
      {this.chiNhanhID, this.cumID, this.ngayxuatDS, this.masoql})
      : super();
}

class DownloadDataCommunityDevelopmentEvent extends DownloadDataEvent {
  String cumID;
  DownloadDataCommunityDevelopmentEvent(this.cumID) : super();
}

class UpdateDownloadDataEvent extends DownloadDataEvent {
  UpdateDownloadDataEvent() : super();
}

class DownloadDataComboBoxEvent extends DownloadDataEvent {
  DownloadDataComboBoxEvent() : super();
}
