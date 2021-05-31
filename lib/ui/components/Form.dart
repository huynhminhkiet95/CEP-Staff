import 'package:flutter/material.dart';
import 'package:qr_code_demo/GlobalTranslations.dart';
import './InputFields.dart';

class FormContainer extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController passwordController;

  FormContainer(
      {@required this.userNameController, @required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Text(allTranslations.text('user_name'),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 198, 81))),
              new Container(
                width: 250,
                child: new InputFieldArea(
                  textController: userNameController,
                  hint: allTranslations.text('pleaseinputuser'),
                  obscure: false,
                ),
              ),
              new Container(
                height: 10,
              ),
              new Text(allTranslations.text('password'),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 198, 81))),
              new Container(
                height: 10,
              ),
              new Container(
                width: 250,
                child: new InputFieldArea(
                  textController: passwordController,
                  hint: allTranslations.text('pleaseinputpassword'),
                  obscure: true,
                ),
              ),
            ],
          )),
        ],
      ),
    ));
  }
}
