import 'dart:async';
import 'dart:io';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_bloc.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_event.dart';
import 'package:qr_code_demo/blocs/application_initiallization/application_initialization_state.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InitializationPage extends StatefulWidget {
  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage>
    with TickerProviderStateMixin {
  ApplicationInitializationBloc bloc;
  Services services;
  AnimationController _controller;
  Animation<double> _animation;

  AnimationController _controller1;
  Animation<double> _animation1;

  AnimationController _controller2;
  Animation<double> _animation2;
  @override
  void initState() {
    super.initState();
    services = Services.of(context);
    bloc = ApplicationInitializationBloc(services.sharePreferenceService);
    bloc.emitEvent(ApplicationInitializationEvent());

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller1 = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _animation1 = CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeIn,
    );

    _controller2 = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _animation2 = CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeIn,
    );

    _controller.forward().then((value) =>
        _controller1.forward().then((value) => _controller2.forward()));
  }

  int percentInit = 0;
  @override
  void dispose() {
    bloc?.dispose();
    _controller.dispose();
    _controller1.dispose();
    super.dispose();
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
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext pageContext) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          body: Container(
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
            // color: Color(
            //     ColorConstants.getColorHexFromStr(ColorConstants.backgroud)),
            // decoration: new BoxDecoration(
            //   image: new DecorationImage(image: new AssetImage("assets/images/initialization.png"), fit: BoxFit.cover,),
            // ),
            child: Center(
              child: BlocEventStateBuilder<ApplicationInitializationState>(
                bloc: bloc,
                builder: (BuildContext context,
                    ApplicationInitializationState state) {
                  if (state.isInitialized) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushReplacementNamed('/decision');
                    });
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedContainer(
                        duration: Duration(milliseconds: 1500),
                        // color: Colors.red,
                        height: 80,
                        width: 120,
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: state.progress == 0.0 ? 5 : 1,
                              offset: Offset(
                                  state.progress == 0.0 ? -5 : 10,
                                  state.progress == 0.0
                                      ? -5
                                      : 10), // changes position of shadow
                            ),
                          ],
                          color: ColorConstants.cepColorBackground,
                          border: Border.all(color: Colors.white, width: 1.0),
                          // backgroundBlendMode: BlendMode.lighten,
                          borderRadius:
                              new BorderRadius.all(Radius.elliptical(60, 40)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeTransition(
                              opacity: _animation,
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/images/C.png",
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 90,
                                ),
                              ),
                            ),
                            FadeTransition(
                              opacity: _animation1,
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/images/E.png",
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 90,
                                ),
                              ),
                            ),
                            FadeTransition(
                              opacity: _animation2,
                              child: Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/images/P.png",
                                  fit: BoxFit.contain,
                                  height: 40,
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 100,
                      ),
                      // Divider(
                      //   height: 30.0,
                      //   color: Colors.white,
                      // ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Center(
                            child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * 0.9,
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 3000,
                              percent: 1,
                              center: Text(
                                state.progress.toString() + "%",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.green,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 100,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
