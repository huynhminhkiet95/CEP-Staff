import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideTopRoute extends PageRouteBuilder {
  final Widget page;
  SlideTopRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideBottomRoute extends PageRouteBuilder {
  final Widget page;
  SlideBottomRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideBottomToTopRoute extends PageRouteBuilder {
  final Widget page;
  SlideBottomToTopRoute({this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale:
                          Tween<double>(begin: 0.99, end: 1).animate(animation),
                      child: child,
                    ),
                  ),
                ));
}

class SlideTransferRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideTransferRightRoute({this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              Widget secondaryPage = new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset(0.0, 0.0),
                  end: Offset(-1.0, 0.0),
                ).animate(CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Interval(0.3, 0.7, curve: Curves.easeInOut))),
                child: new ScaleTransition(
                  scale: new Tween<double>(
                    begin: 1.0,
                    end: 0.9,
                  ).animate(CurvedAnimation(
                      parent: secondaryAnimation,
                      curve: Interval(0.0, 0.3, curve: Curves.easeInOut))),
                  child: new ScaleTransition(
                    scale: new Tween<double>(
                      begin: 1.0,
                      end: 0.9,
                    ).animate(CurvedAnimation(
                        parent: secondaryAnimation,
                        curve: Interval(0.3, 1.0, curve: Curves.easeInOut))),
                    child: child,
                  ),
                ),
              );
              return new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset(0.0, 0.0),
                ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Interval(0.3, 0.7, curve: Curves.easeInOut))),
                child: new ScaleTransition(
                  scale: new Tween<double>(
                    begin: 0.9,
                    end: 1.0,
                  ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Interval(0.0, 0.3, curve: Curves.easeInOut))),
                  child: new ScaleTransition(
                    scale: new Tween<double>(
                      begin: 0.9,
                      end: 1.0,
                    ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Interval(0.7, 1.0, curve: Curves.easeInOut))),
                    child: secondaryPage,
                  ),
                ),
              );
            });
}

class SlideLeftRouteZoomPage extends PageRouteBuilder {
  final Widget page;
  SlideLeftRouteZoomPage({this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              Widget secondaryPage = new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset(0.0, 0.0),
                  end: Offset(-1.0, 0.0),
                ).animate(CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Interval(0.3, 0.7, curve: Curves.easeInOut))),
                child: new ScaleTransition(
                  scale: new Tween<double>(
                    begin: 1.0,
                    end: 0.9,
                  ).animate(CurvedAnimation(
                      parent: secondaryAnimation,
                      curve: Interval(0.0, 0.3, curve: Curves.easeInOut))),
                  child: new ScaleTransition(
                    scale: new Tween<double>(
                      begin: 1.0,
                      end: 0.9,
                    ).animate(CurvedAnimation(
                        parent: secondaryAnimation,
                        curve: Interval(0.3, 1.0, curve: Curves.easeInOut))),
                    child: child,
                  ),
                ),
              );
              return new SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: secondaryPage,
              );
            });
}
