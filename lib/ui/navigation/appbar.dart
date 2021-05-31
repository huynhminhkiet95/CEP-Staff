import 'package:flutter/material.dart';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/config/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String titleKey;
  final String route;
  final Icon iconButton;

  CustomAppBar(Key key, this.titleKey, this.route, this.iconButton)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: ColorConstants.yellowColor,
        title: Text(allTranslations.text(titleKey)),
        leading: new IconButton(
            icon: iconButton,
            onPressed: () {
              Navigator.pushReplacementNamed(context, route);
            }));
  }
}
