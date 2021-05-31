import 'package:qr_code_demo/config/group_menu_enum.dart';

String textMenuName(String data) {
  String str = data;
  switch (data) {
    case GroupMenuType.localDistribution:
      str = "Local Distribution";
      break;
    case GroupMenuType.warehouseMenu:
      str = "Ware House";
      break;
    case GroupMenuType.packages:
      str = "Packages";
      break;
    case GroupMenuType.general:
      str = "Other";
      break;
  }
  return str;
}
