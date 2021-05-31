import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends BlocEvent {
  final String userName;
  final String password;
  final bool isRemember;

  AuthenticationEvent(
      {this.userName: '', this.password: '', this.isRemember: false});
}

class LoadDefaultUserEvent extends AuthenticationEvent {
  LoadDefaultUserEvent() : super();
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String userName;
  final String password;
  final bool isRemember;

  AuthenticationEventLogin({
    this.userName,
    this.password,
    this.isRemember,
  }) : super(userName: userName, password: password, isRemember: isRemember);
}

class AuthenticationEventLogout extends AuthenticationEvent {}

class LoadCurrentVersionEvent extends AuthenticationEvent {}
