import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ModalProgressHUDCustomize extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Offset offset;
  final bool dismissible;
  final Widget child;

  ModalProgressHUDCustomize({
    Key key,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.offset,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        progressIndicator: progressIndicator(),
        color: Colors.black,
        child: child,
        inAsyncCall: inAsyncCall,
        dismissible: dismissible,
        opacity: 0.5);
  }

  Widget progressIndicator() {
    return Container(
      width: 200.0,
      height: 100.0,
      alignment: AlignmentDirectional.center,
      decoration: new BoxDecoration(
          color: Colors.green[900].withOpacity(0.5),
          borderRadius: new BorderRadius.circular(10.0)),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          new Divider(
            height: 10,
            color: Color(0x00000000),
          ),
          new Text(
            "Loading...",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
