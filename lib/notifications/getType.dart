import 'package:flutter/widgets.dart';

import '../GlobalTranslations.dart';

String getTypeNotification(String type) {
  switch (type) {
    case "0":
      return allTranslations.text('NewAssign');
    case "1":
      return allTranslations.text('NewTrip');
    case "2":
      return allTranslations.text('NewMessage');
    case "3":
      return allTranslations.text('NewMessage');
    default:
      return allTranslations.text('NewMessage');
  }
}

Image getIconNotification(String type) {
  switch (type) {
    case "0":
      return new Image.asset('assets/images/icon_todo.png', width: 30, height: 30);
    case "1":
      return new Image.asset('assets/images/carpick.jpg', width: 30, height: 30);
    case "2":
      return new Image.asset('assets/images/fightpic.png', width: 30, height: 30);
    case "3":
      return new Image.asset('assets/images/new-icon.png', width: 30, height: 30);
    default:
      return new Image.asset('assets/images/icon_todo.png', width: 30, height: 30);
  }
}
