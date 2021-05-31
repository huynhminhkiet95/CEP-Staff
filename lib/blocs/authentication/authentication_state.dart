import 'package:flutter/material.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

class AuthenticationState extends BlocState {
  AuthenticationState(
      {@required this.isAuthenticated,
      this.isAuthenticating: false,
      this.hasFailed: false,
      this.serverCode: "DEV-VPN",
      this.isRemember: false,
      this.userName: "",
      this.password: "",
      this.userIsNotExit: false});

  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool hasFailed;
  final String serverCode;
  final bool isRemember;
  final String userName;
  final String password;
  final bool userIsNotExit;

  factory AuthenticationState.initAuthenticationState() {
    return AuthenticationState(isAuthenticated: false);
  }

  factory AuthenticationState.defaultAuthenticationState(
      bool isRemember, String userName, String password, String serverCode) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: false,
        isAuthenticating: false,
        serverCode: serverCode,
        isRemember: isRemember,
        userName: userName,
        password: password,
        userIsNotExit: false);
  }

  factory AuthenticationState.initUserInfor(
      bool isRemember, String userName, String password) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: true,
        isAuthenticating: false,
        isRemember: isRemember,
        userName: userName,
        password: password,
        userIsNotExit: false);
  }

  factory AuthenticationState.userIsNotExits(
      AuthenticationState currentState, bool userIsNotExit) {
    return AuthenticationState(
        isAuthenticated: false,
        isAuthenticating: false,
        isRemember: currentState.isRemember,
        userName: currentState.userName,
        password: currentState.password,
        userIsNotExit: userIsNotExit);
  }

  factory AuthenticationState.notAuthenticated(
      String userName, String password, bool isRemember) {
    return AuthenticationState(
        isAuthenticated: false,
        isAuthenticating: false,
        isRemember: isRemember,
        userName: userName,
        password: password,
        userIsNotExit: false);
  }

  factory AuthenticationState.rememberInfo(AuthenticationState currentState,
      String userName, String password, bool isRemember) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: false,
        isAuthenticating: false,
        isRemember: isRemember,
        userName: userName,
        password: password,
        serverCode: currentState?.serverCode,
        userIsNotExit: false);
  }

  factory AuthenticationState.authenticated(
      bool isRemember, String userName, String password, String serverCode) {
    return AuthenticationState(
        isAuthenticated: true,
        isAuthenticating: false,
        isRemember: isRemember,
        userName: userName,
        password: password,
        serverCode: serverCode,
        userIsNotExit: false);
  }

  factory AuthenticationState.authenticating(AuthenticationState currentState) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: false,
        isAuthenticating: true,
        userName: currentState?.userName,
        password: currentState?.password,
        isRemember: currentState?.isRemember,
        serverCode: currentState?.serverCode,
        userIsNotExit: false);
  }

  factory AuthenticationState.failedByServer(AuthenticationState currentState) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: true,
        isAuthenticating: false,
        isRemember: currentState?.isRemember ?? false,
        userName: currentState?.userName ?? "",
        password: currentState?.password ?? "",
        userIsNotExit: false);
  }

  factory AuthenticationState.failedByUser(AuthenticationState currentState) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: false,
        isAuthenticating: false,
        isRemember: currentState?.isRemember ?? false,
        userName: currentState?.userName ?? "",
        password: currentState?.password ?? "",
        userIsNotExit: true);
  }

  factory AuthenticationState.updateSelectServer(
      AuthenticationState currentState, String serverCode) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: false,
        isAuthenticating: false,
        serverCode: serverCode,
        isRemember: currentState?.isRemember ?? false,
        userName: currentState?.userName ?? "",
        password: currentState?.password ?? "",
        userIsNotExit: false);
  }

  factory AuthenticationState.updateRemember(
      AuthenticationState currentState, bool isRemember) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: false,
        isAuthenticating: false,
        isRemember: isRemember,
        userName: currentState?.userName ?? "",
        password: currentState?.password ?? "",
        serverCode: currentState?.serverCode ?? "",
        userIsNotExit: false);
  }

  factory AuthenticationState.updateUserName(
      AuthenticationState currentState, String userName) {
    return AuthenticationState(
        isAuthenticated: false,
        hasFailed: false,
        isAuthenticating: false,
        serverCode: currentState?.serverCode ?? "PROD",
        isRemember: currentState?.isRemember ?? false,
        userName: userName ?? "",
        password: currentState.password ?? "",
        userIsNotExit: false);
  }

  factory AuthenticationState.updatePassword(
      AuthenticationState currentState, String password) {
    return AuthenticationState(
        isAuthenticated: false,
        isAuthenticating: false,
        serverCode: currentState?.serverCode ?? "PROD",
        isRemember: currentState?.isRemember ?? false,
        userName: currentState.userName ?? "",
        password: password ?? "",
        hasFailed: false,
        userIsNotExit: false);
  }
}
