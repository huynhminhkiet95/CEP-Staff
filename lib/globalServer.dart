class GlobalServer {
  String _serverAddress;
  String _serverCode;
  String _serverNotification;
  String _serverInspection;
  String _serverApi;
  String _serverHub;
  String _serverSSO;


  String get getServerAddress => _serverAddress;

  set setServerAddress(String value) => _serverAddress = value;

  String get getServerCode => _serverCode;

  set setServerCode(String value) => _serverCode = value;

  String get getServerNotification => _serverNotification;

  set setServerNotification(String value) => _serverNotification = value;

  String get getServerInspection => _serverInspection;

  set setServerInspection(String value) => _serverInspection = value;

  String get getServerApi => _serverApi;

  set setServerApi(String value) => _serverApi = value;

  String get getServerHub => _serverHub;

  set setServerHub(String value) => _serverHub = value;

  String get getServerSSO => _serverSSO;

  set setServerSSO(String value) => _serverSSO = value;


  static final GlobalServer _translations = new GlobalServer._internal();

  factory GlobalServer() {
    return _translations;
  }

  GlobalServer._internal();
}

GlobalServer globalServer = new GlobalServer();
