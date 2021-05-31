import 'dart:io';

import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_provider.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_bloc.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_event.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_state.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/models/dashboard/ItemDashboard.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:flutter/material.dart';

import '../../../GlobalTranslations.dart';
//import 'package:path/path.dart';

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with TickerProviderStateMixin {
  AnimationController _animationControllerItemMenu;
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  AnimationController _animationController;
  final Duration duration = const Duration(milliseconds: 400);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  AuthenticationBloc authenticationBloc;
  Services services;
  SharePreferenceService _sharePreferenceService;
  @override
  void initState() {
    super.initState();
    services = Services.of(context);
    // authenticationBloc = new AuthenticationBloc(
    //     services.commonService, services.sharePreferenceService);

    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    _animationControllerItemMenu = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationControllerItemMenu?.dispose();
    _animationController.dispose();
    authenticationBloc.dispose();
    super.dispose();
  }

  void _onTapMenuItem(String router) {
    if (router == "logout") {
      globalUser.settoken = "";
      this.services.sharePreferenceService.saveToken("");
      Navigator.pushNamed(context, '/welcomeLogin');
      return;
    }
    Navigator.pushNamed(context, router);
  }

  // void _loginSubmit() {

  //   authenticationBloc.emitEvent(AuthenticationEventLogout());
  // }

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocEventStateBuilder<AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            return Scaffold(
              backgroundColor: ColorConstants.cepColorBackground,
              body: Stack(
                children: <Widget>[
                  menu(context),
                  dashboard(context),
                ],
              ),
            );
          }),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      "assets/dashboard/cep-slogan-intro.png",
                      width: 0.65 * screenWidth,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, 'userprofile');
                      },
                      title: Text(
                        globalUser.getUserInfo == null
                            ? ''
                            : globalUser.getUserInfo.hoTen,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.verified_user, color: Colors.yellowAccent),
                          Text(
                              globalUser.getUserInfo == null
                                  ? ''
                                  : " ${allTranslations.text("CodeNumber")} " +
                                      globalUser.getUserInfo.masoql,
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                      leading: Container(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Icon(
                          Icons.account_circle_sharp,
                          color: Colors.white,
                          size: 0.099 * screenWidth,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.06),
                  Expanded(
                    child: Container(
                      width: 370,
                      decoration: new BoxDecoration(
                          color: ColorConstants.cepColorBackground),
                      child: ListView(
                          padding: EdgeInsets.all(0), children: getListMenu()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getListMenu() {
    List<Widget> listWidget = new List<Widget>();
    var listMenuByUser = ItemDashBoard.getItemDashboard();
    var listMenuDefault = ItemDashBoard.getItemMenuDefault();

    for (var item in listMenuByUser) {
      bool isDisable = false;

      if (globalUser.getUserName == "kiet.hm") {
      } else {
        switch (item.router) {
          case "error":
            isDisable = true;
            break;
          case "personalinforuser":
            isDisable = true;
            break;

          default:
        }
      }
      listWidget.add(
        Divider(
          color: Colors.white,
          height: 2,
        ),
      );

      Widget widgetTileMenu = Material(
        color: isDisable ? Colors.grey : ColorConstants.cepColorBackground,
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            if (!isDisable) {
              _onTapMenuItem(item.router);
            }
          },
          child: Container(
            color: Colors.blue[100].withOpacity(0),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: screenWidth * 0.07,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  item.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
        ),
      );
      listWidget.add(widgetTileMenu);
    }

    for (var item in listMenuDefault) {
      listWidget.add(
        Divider(
          color: Colors.white,
          height: 2,
        ),
      );
      Widget widgetTileMenu = Material(
        color: ColorConstants.cepColorBackground,
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            _onTapMenuItem(item.router);
          },
          child: Container(
            color: Colors.blue[100].withOpacity(0),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: screenWidth * 0.07,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  item.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 70,
                ),
              ],
            ),
          ),
        ),
      );
      listWidget.add(widgetTileMenu);
    }

    return listWidget;
  }

  Widget dashboard(context) {
    List<ItemDashBoard> listDashboard = ItemDashBoard.getItemDashboard();
    var color = ColorConstants.cepColorBackground;
    var border = !isCollapsed
        ? BorderRadius.all(Radius.circular(40))
        : BorderRadius.all(Radius.circular(0));

    // var menuIcon = isCollapsed
    //     ? Icon(
    //         Icons.menu,
    //         color: Colors.white,
    //         size: screenWidth * 0.06,
    //       )
    //     : Icon(
    //         Icons.close_rounded,
    //         color: Colors.white,
    //         size: screenWidth * 0.06,
    //       );
    Orientation orientation = MediaQuery.of(context).orientation;

    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.7 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: border,
          elevation: 8,
          shadowColor: Colors.brown,
          color: ColorConstants.cepColorBackground,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                int sensitivity = 8;
                if (details.delta.dx > sensitivity) {
                  setState(() {
                    if (isCollapsed) {
                      isCollapsed = !isCollapsed;
                      _controller.forward();
                      _animationController.forward();
                    }
                  });
                } else if (details.delta.dx < -sensitivity) {
                  //Left Swipe
                  setState(() {
                    if (!isCollapsed) {
                      isCollapsed = !isCollapsed;
                      _controller.reverse();
                      _animationController.reverse();
                    }
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          //  child: menuIcon,
                          child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            color: Colors.white,
                            progress: _animationController,
                          ),
                          onTap: () {
                            setState(() {
                              if (isCollapsed) {
                                _controller.forward();
                                _animationController.forward();
                              } else {
                                _controller.reverse();
                                _animationController.reverse();
                              }

                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                        Text(allTranslations.text("Dashboard"),
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            )),
                        Icon(Icons.notifications, color: Colors.white),
                      ],
                    ),
                    Container(
                      height: screenHeight * 0.8,
                      width: screenWidth * 1,
                      margin: EdgeInsets.only(top: 20),
                      child: GridView.count(
                          childAspectRatio:
                              orientation == Orientation.portrait ? 1.0 : 1.3,
                          padding: EdgeInsets.only(
                              left: 16, right: 16, bottom: 10, top: 10),
                          crossAxisCount:
                              orientation == Orientation.portrait ? 3 : 4,
                          crossAxisSpacing:
                              orientation == Orientation.portrait ? 10 : 30,
                          mainAxisSpacing:
                              orientation == Orientation.portrait ? 10 : 30,
                          children: new List<Widget>.generate(
                              listDashboard.length, (index) {
                            // listDashboard.map((data) {
                            final int count = listDashboard.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _animationControllerItemMenu,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            _animationControllerItemMenu.forward();

                            return AnimatedBuilder(
                                animation: _animationControllerItemMenu,
                                builder: (BuildContext context, Widget child) {
                                  bool isDisable = false;

                                  if (globalUser.getUserName == "kiet.hm") {
                                  } else {
                                    switch (listDashboard[index].router) {
                                      case "error":
                                        isDisable = true;
                                        break;
                                      case "personalinforuser":
                                        isDisable = true;
                                        break;

                                      default:
                                    }
                                  }

                                  return FadeTransition(
                                    opacity: animation,
                                    child: Transform(
                                      transform: Matrix4.translationValues(
                                          50 * (1.0 - animation.value),
                                          0.0,
                                          0.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (!isDisable) {
                                            _onTapMenuItem(
                                                listDashboard[index].router);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 3.0,
                                                  color: Colors.white),
                                              color: isDisable
                                                  ? Colors.grey
                                                  : color,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                listDashboard[index].img,
                                                width: screenWidth * 0.07,
                                              ),
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  listDashboard[index].title,
                                                  textAlign: TextAlign.center,
                                                  // overflow: TextOverflow.fade,
                                                  //maxLines: 1,
                                                  // softWrap: false,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }).toList()),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
