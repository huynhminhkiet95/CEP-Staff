import 'package:qr_code_demo/models/users/ValidateUserIdPwdJsonResult.dart';
import 'package:rxdart/rxdart.dart';

class GlobalBloc {
  ///
  /// Streams related to this BLoC
  ///
  BehaviorSubject<String> _controller = BehaviorSubject<String>();

  Function(String) get push => _controller.sink.add;

  Stream<String> get stream => _controller;

  BehaviorSubject<UserInfoPwdJsonResult> _userController =
      BehaviorSubject<UserInfoPwdJsonResult>();

  Function(UserInfoPwdJsonResult) get addUserInfo => _userController.sink.add;

  Stream<UserInfoPwdJsonResult> get geeUserInfo => _userController;

  ///
  /// Singleton factory
  ///
  static final GlobalBloc _bloc = new GlobalBloc._internal();

  factory GlobalBloc() {
    return _bloc;
  }

  GlobalBloc._internal();

  ///
  /// Resource disposal
  ///
  void dispose() {
    _controller?.close();
    _userController?.close();
  }
}

GlobalBloc globalBloc = GlobalBloc();
