import 'package:flutter/material.dart';

class LoadingProgressIndicator extends StatelessWidget {
  final String _displayText;

  LoadingProgressIndicator(this._displayText);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        content: Container(
            width: 250.0,
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(_displayText,
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Color(0xFF5B6978),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}
