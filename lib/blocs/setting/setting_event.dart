import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

abstract class SettingEvent extends BlocEvent {
  SettingEvent();
}

class LoadAuthenLocalEvent extends SettingEvent {
  LoadAuthenLocalEvent() : super();
}

class UpdateAuthenLocalEvent extends SettingEvent {
  final String password;
  final bool isAuthenRadio;
  UpdateAuthenLocalEvent(this.password, this.isAuthenRadio) : super();
}
