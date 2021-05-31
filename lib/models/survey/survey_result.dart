import 'package:qr_code_demo/models/download_data/historysearchsurvey.dart';
import 'package:qr_code_demo/models/download_data/survey_info.dart';
import 'package:qr_code_demo/models/download_data/survey_info_history.dart';

class SurveyStream {
  List<SurveyInfo> listSurvey;
  List<HistorySearchSurvey> listHistorySearch;
  List<SurveyInfoHistory> listSurveyInfoHistory;
  String cumID;
  String ngayXuatDS;
  SurveyStream(
      {this.listSurvey,
      this.listHistorySearch,
      this.listSurveyInfoHistory,
      this.cumID,
      this.ngayXuatDS});
}
