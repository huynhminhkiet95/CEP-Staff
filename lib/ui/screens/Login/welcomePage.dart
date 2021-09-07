import 'dart:io';

import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_provider.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_bloc.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_event.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_state.dart';
import 'package:qr_code_demo/config/version.dart';
import 'package:qr_code_demo/global_variables/global_update.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

import '../../../GlobalTranslations.dart';
// import 'package:flutter_login_signup/src/loginPage.dart';
// import 'package:flutter_login_signup/src/signup.dart';
// import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double screenWidth, screenHeight;
  Services services;
  AuthenticationBloc authenticationBloc;
  final LocalAuthentication localAuth = LocalAuthentication();
  int _isAuthenType = 0;

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Đăng Nhập bằng tài khoản',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Đăng nhập bằng vân tay.',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => showAuthenPopup(),
              child: Icon(Icons.fingerprint,
                  size: screenHeight * 0.1, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => showAuthenPopup(),
              child: Text(
                'Touch ID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void deactivate() {
    // Todo: implement deactivate
    print("deactivate");
    super.deactivate();
  }

  @override
  void setState(fn) {
    print("setState");

    // todo: implement setState
    super.setState(fn);
  }

  @override
  void initState() {
    services = Services.of(context);
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.emitEvent(LoadCurrentVersionEvent());
    // checknewVersion();
    // Todo: implement initState
    //
    super.initState();
    if (GlobalUpdate.isNewVersion == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDialogUpdate();
      });
    } else {
      checkBiometric();
      if (globalUser.getAuthenLocal) {
        showAuthenPopup();
      }
    }

    print("initState");
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  /*
    This method is called immediately after initState on the first time the widget is built.
    */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocEventStateBuilder<AuthenticationState>(
              bloc: authenticationBloc,
              builder: (BuildContext context, AuthenticationState state) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff223f92),
                            Color(0xff223f92),
                            Color(0xff0bf7c1),
                          ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //_title(),
                      SizedBox(
                        height: screenHeight * 0.2,
                        child: Image.asset(
                          'assets/logo/cep-large-icon-logo-intro.png',
                          width: 150.0,
                          height: 130.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.15,
                      ),
                      _loginButton(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      _label()
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<bool> checkVersion() async {
    return false;
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showDialogUpdate() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: new Text("Update"),
            content: new Text(allTranslations.text("UpdateVersion")),
            actions: <Widget>[
              new FlatButton(
                child: new Text(allTranslations.text("OK")),
                onPressed: () {
                  goUpdateApp();
                  exit(0);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void goUpdateApp() async {
    LaunchReview.launch(
        androidAppId: 'com.cep.CEPstaff', iOSAppId: '1477031564');
  }

  Future<void> checkBiometric() async {
    try {
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      if (!mounted) return;
      setState(() {});

      if (canCheckBiometrics) {
        _getAvailableBiometrics();
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await localAuth.getAvailableBiometrics();
      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          setState(() {
            _isAuthenType = 1;
          });
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          _isAuthenType = 2;
        }
      } else {
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          _isAuthenType = 2;
        }
      }
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    // setState(() {
    //   _biometricTypes = availableBiometrics;
    // });
  }

  showAuthenPopup() async {
    var localAuth = LocalAuthentication();
    try {
      var androidStrings = AndroidAuthMessages(
          cancelButton: allTranslations.text("Cancel"),
          goToSettingsButton: allTranslations.text("Settings"),
          goToSettingsDescription: allTranslations.text("PleaseSetupTouchID"),
          fingerprintSuccess: allTranslations.text("SuccessfulAuthentication"),
          fingerprintHint: "",
          fingerprintRequiredTitle: allTranslations.text("SetupTouchID"),
          signInTitle: "Touch ID for CEP-Nhân viên",
          fingerprintNotRecognized:
              allTranslations.text("FingerPrintingNotAvailable"));
      bool isAuthenticate = await localAuth.authenticateWithBiometrics(
          localizedReason:
              allTranslations.text("PleaseScanYourFingerprintToLogin"),
          stickyAuth: true,
          androidAuthStrings: androidStrings);
      if (isAuthenticate) {
        _loginSubmitWithAuthenLocal();
      }
      print('isAuthenticate: ' + isAuthenticate.toString());
    } on PlatformException catch (e) {
      print(e);
    }
  }

  void _loginSubmitWithAuthenLocal() {
    authenticationBloc.emitEvent(AuthenticationEventLogin(
        userName: globalUser.getRememberUserName.toString().toLowerCase(),
        password: globalUser.getPassword.toString(),
        isRemember: true));
  }
}
