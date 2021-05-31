import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_event.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_state.dart';
import 'package:qr_code_demo/dtos/serverInfo.dart';
import 'package:qr_code_demo/services/sharePreference.dart';

class ApplicationInitializationBloc extends BlocEventStateBase<
    ApplicationInitializationEvent, ApplicationInitializationState> {
  final SharePreferenceService _sharePreferenceService;

  ApplicationInitializationBloc(this._sharePreferenceService)
      : super(initialState: ApplicationInitializationState.notInitialized());

  @override
  Stream<ApplicationInitializationState> eventHandler(
      ApplicationInitializationEvent event,
      ApplicationInitializationState currentState) async* {
    String _server = 'PROD';
    if (!currentState.isInitialized) {
      yield ApplicationInitializationState.notInitialized();
    }

    if (event.type == ApplicationInitializationEventType.start) {
      for (double progress = 0; progress < 101; progress += 1) {
        await Future.delayed(const Duration(milliseconds: 30));
        yield ApplicationInitializationState.progressing(progress);
      }
      var server = new ServerInfo();
      switch (_server) {
        case "DEV-VPN":
          server.serverAddress = "http://10.10.0.36:8889/";
          server.serverApi = "http://10.10.0.36:8889/";
          server.serverCode = _server;
          server.serverNotification = "http://10.10.0.36:8889/";
          break;
        case "PROD":
          server.serverAddress = "https://staff-api.cep.org.vn/";
          server.serverApi = "https://staff-api.cep.org.vn/";
          server.serverCode = _server;
          server.serverNotification = "https://staff-api.cep.org.vn/";
          break;
      }
      this._sharePreferenceService.updateServerInfo(server);
    }

    if (event.type == ApplicationInitializationEventType.initialized) {
      yield ApplicationInitializationState.initialized();
    }
  }
}
