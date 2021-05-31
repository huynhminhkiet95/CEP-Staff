import 'package:flutter/material.dart';

import '../../../GlobalTranslations.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        elevation: 20,
        title: Text(
          "Error",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            
            Center(
              child: Container(
                height: 300,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          Image.asset('assets/images/no_data.gif',
                              width: 180, height: 180),
                          Text(
                            allTranslations.text("NoDataFound"),
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                                wordSpacing: 1),
                          ),
                        
                          RaisedButton(
                            onPressed: () {
                            
                            },
                            child: Text(
                              allTranslations.text("TryAgain"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            color: Colors.cyan,
                            textColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
