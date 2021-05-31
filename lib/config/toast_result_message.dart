import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastResultMessage {
  static void success(String message) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIos: 10,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.green[600].withOpacity(0.9),
      textColor: Colors.white,
    );
  }

  static void error(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.red[300].withOpacity(0.7),
      textColor: Colors.white,
    );
  }
  static void warning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.yellow[300].withOpacity(0.7),
      textColor: Colors.white,
    );
  }

  static void info(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.grey[300].withOpacity(0.7),
      textColor: Colors.white,
    );
  }
}
