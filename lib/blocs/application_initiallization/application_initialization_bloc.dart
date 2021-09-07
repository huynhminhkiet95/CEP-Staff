import 'dart:convert';

import 'package:package_info/package_info.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_event.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_state.dart';
import 'package:qr_code_demo/dtos/serverInfo.dart';
import 'package:qr_code_demo/global_variables/global_update.dart';
import 'package:qr_code_demo/httpProvider/HttpProviders.dart';
import 'package:qr_code_demo/models/common/version_staff.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:rxdart/subjects.dart';

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
        if (progress == 30) {
          var httpBase = new HttpBase();
          CommonService _commonService = new CommonService(httpBase);
          var response = await _commonService.getCurrentVersion();
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
        }
        await Future.delayed(const Duration(milliseconds: 30));
        yield ApplicationInitializationState.progressing(progress);
      }
    }

    if (event.type == ApplicationInitializationEventType.initialized) {
      yield ApplicationInitializationState.initialized();
    }
  }
}
