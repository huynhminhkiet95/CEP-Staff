import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/config/toast_result_message.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/ui/components/Widget/bezierContainer.dart';
import 'package:qr_code_demo/ui/screens/Login/loginPage.dart';
import 'package:flutter/material.dart';

import '../../../GlobalTranslations.dart';
// import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
// import 'package:flutter_login_signup/src/loginPage.dart';
// import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _userNameController =
      new TextEditingController(text: "");
  TextEditingController _emailController = new TextEditingController(text: "");
  TextEditingController _phoneController = new TextEditingController(text: "");
  TextEditingController _passwordController =
      new TextEditingController(text: "");
  TextEditingController _confirmPasswordController =
      new TextEditingController(text: "");
  TextEditingController _fullnameController =
      new TextEditingController(text: "");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void _registerSubmit() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      var model = {
        "username": _userNameController.text,
        "fullname": _fullnameController.text,
        "password": _passwordController.text,
        "phone": _phoneController.text,
        "email": _emailController.text,
      };
      int rs = await DBProvider.db.newRegisterAccount(model);
      if (rs > 0) {
        ToastResultMessage.success(allTranslations.text("RegisterSuccessfuly"));
        Navigator.pop(context, _userNameController.text);
      } else {
        ToastResultMessage.error(allTranslations.text("ServerNotFound"));
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: _registerSubmit,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 45,
        //padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          allTranslations.text("RegisterNow"),
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget formTextField() {
    return Column(
      children: <Widget>[
        TextFormField(
            controller: _userNameController,
            style: TextStyle(color: Colors.blue),
            validator: (String str) {
              if (str.length < 1)
                return allTranslations.text("UserNameValidation");
              else
                return null;
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                ),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: allTranslations.text("user_name"),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                suffixStyle: TextStyle(color: Colors.red))),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            controller: _fullnameController,
            style: TextStyle(color: Colors.blue),
            validator: (String str) {
              if (str.length < 1)
                return allTranslations.text("FullNameValidation");
              else
                return null;
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                ),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: allTranslations.text("FullName"),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                suffixStyle: TextStyle(color: Colors.red))),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            controller: _emailController,
            style: TextStyle(color: Colors.blue),
            validator: (String str) {
              if (str.length < 1)
                return allTranslations.text("EmailValidation");
              else {
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(str);
                if (!emailValid) {
                  return allTranslations.text("EmailNotMatch");
                } else {
                  return null;
                }
              }
              // else
              //   return null;
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                ),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: allTranslations.text("Email"),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                suffixStyle: TextStyle(color: Colors.red))),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            controller: _phoneController,
            style: TextStyle(color: Colors.blue),
            validator: (String str) {
              if (str.length < 1)
                return allTranslations.text("PhoneValidation");
              else {
                bool phoneValid =
                    RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(str);
                if (!phoneValid) {
                  return allTranslations.text("PhoneNotMatch");
                } else {
                  return null;
                }
              }
              //  return null;
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                ),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: allTranslations.text("PhoneNumber"),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                suffixStyle: TextStyle(color: Colors.red))),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            controller: _passwordController,
            style: TextStyle(color: Colors.blue),
            validator: (String str) {
              if (str.length < 1)
                return allTranslations.text("PasswordValidation");
              else
                return null;
            },
            obscureText: true,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                ),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: allTranslations.text("password"),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                suffixStyle: TextStyle(color: Colors.red))),
        SizedBox(
          height: 20,
        ),
        TextFormField(
            controller: _confirmPasswordController,
            style: TextStyle(color: Colors.blue),
            validator: (String str) {
              if (str.length < 1)
                return allTranslations.text("ConfirmPasswordValidation");
              else {
                if (str != _passwordController.text) {
                  return allTranslations.text("PasswordNotMatch");
                } else {
                  return null;
                }
              }
            },
            obscureText: true,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                ),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: allTranslations.text("confirmpassword"),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                suffixStyle: TextStyle(color: Colors.red))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        color: ColorConstants.cepColorBackground,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  autovalidate: _autoValidate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .15),
                      SizedBox(
                        height: 50,
                      ),
                      formTextField(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
