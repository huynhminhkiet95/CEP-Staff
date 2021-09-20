import 'dart:convert';
import 'dart:io';

import 'package:package_info/package_info.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_event.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_state.dart';
import 'package:qr_code_demo/config/status_code.dart';
import 'package:qr_code_demo/config/toast_result_message.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/dtos/serverInfo.dart';
import 'package:qr_code_demo/global_variables/global_register.dart';
import 'package:qr_code_demo/global_variables/global_update.dart';
import 'package:qr_code_demo/httpProvider/HttpProviders.dart';
import 'package:qr_code_demo/models/common/version_staff.dart';
import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:rxdart/subjects.dart';

import '../../GlobalTranslations.dart';
import '../../GlobalUser.dart';

class ApplicationInitializationBloc extends BlocEventStateBase<
    ApplicationInitializationEvent, ApplicationInitializationState> {
  final SharePreferenceService _sharePreferenceService;

  ApplicationInitializationBloc(this._sharePreferenceService)
      : super(initialState: ApplicationInitializationState.notInitialized());

  BehaviorSubject<bool> _getIsNewVersionController = BehaviorSubject<bool>();
  Stream<bool> get getIsNewVersionStream => _getIsNewVersionController;

  @override
  void dispose() async {
    await _getIsNewVersionController.drain();
    _getIsNewVersionController?.close();
    super.dispose();
  }

  @override
  Stream<ApplicationInitializationState> eventHandler(
      ApplicationInitializationEvent event,
      ApplicationInitializationState currentState) async* {
    String _server = 'PROD';
    if (!currentState.isInitialized) {
      yield ApplicationInitializationState.notInitialized();
    }

    if (event.type == ApplicationInitializationEventType.start) {
      var server = new ServerInfo();
      switch (_server) {
        case "DEV-VPN":
          server.serverAddress = "http://10.10.0.51:8080/";
          server.serverApi = "http://10.10.0.51:8080/";
          server.serverCode = _server;
          server.serverNotification = "http://10.10.0.51:8080/";
          break;
        case "PROD":
          server.serverAddress = "https://staff-api.cep.org.vn/";
          server.serverApi = "https://staff-api.cep.org.vn/";
          server.serverCode = _server;
          server.serverNotification = "https://staff-api.cep.org.vn/";
          break;
      }
      this._sharePreferenceService.updateServerInfo(server);
      GlobalUpdate.isNewVersion = false;
      for (double progress = 0; progress < 101; progress += 1) {
        if (progress == 91) {
          var httpBase = new HttpBase();
          CommonService _commonService = new CommonService(httpBase);
          var response = await _commonService.getCurrentVersion();
          var responseRegister = await _commonService.getCanRegister();

          if (response != null &&
              response.statusCode == 200 &&
              response.body.isNotEmpty) {
            var dataJson = json.decode(response.body);
            if (dataJson['data'].isNotEmpty) {
              VersionStaff versionStaff =
                  VersionStaff.fromJson(dataJson['data']);
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              String buildNumber = packageInfo.buildNumber;
              if (int.parse(buildNumber) < versionStaff.maPhienBan) {
                print("false");
                _getIsNewVersionController.sink.add(true);
                GlobalUpdate.isNewVersion = true;
              } else {
                _getIsNewVersionController.sink.add(false);
                GlobalUpdate.isNewVersion = false;
                print("true");
              }
            }
          }

          if (responseRegister != null &&
              responseRegister.statusCode == 200 &&
              responseRegister.body.isNotEmpty) {
            var dataJsonRegister = json.decode(responseRegister.body);
            if (dataJsonRegister['data'].isNotEmpty) {
              var data = dataJsonRegister['data'] as Map;
              GlobalRegister.isRegister = data['isRegister'];
            }
          }
          List<ComboboxModel> metaDataList =
              await DBProvider.db.getAllMetaDataForTBD();
          if (metaDataList.length == 0) {
            var response = await _commonService.downloadDataComboBox();
            if (response.statusCode == StatusCodeConstants.OK) {
              var jsonBody = json.decode(response.body);
              if (jsonBody["isSuccessed"]) {
                if (jsonBody["data"] != null || !jsonBody["data"].isEmpty) {
                  insertMetaDataJsonToSqlite(jsonBody["data"]);
                }
              } else {
                ToastResultMessage.error(
                    allTranslations.text("ServerNotFound"));
              }
            } else {
              ToastResultMessage.error(allTranslations.text("ServerNotFound"));
            }
          }
        }
        await Future.delayed(const Duration(milliseconds: 30));
        yield ApplicationInitializationState.progressing(progress);
      }
    }

    if (event.type == ApplicationInitializationEventType.initialized) {
      yield ApplicationInitializationState.initialized();
    }
  }

  void insertMetaDataJsonToSqlite(dynamic data) async {
    List<ComboboxModel> listCombobox = new List<ComboboxModel>();
    for (var item in data) {
      var listKhaoSat = ComboboxModel.fromJson(item);
      listCombobox.add(listKhaoSat);
    }
    globalUser.setListComboboxModel = listCombobox;
    await DBProvider.db.newMetaDataForTBD(listCombobox);
    ToastResultMessage.success(allTranslations.text("DownLoadDataSuccess"));
  }
}
