import 'package:qr_code_demo/models/common/PageMenuPermission.dart';
import 'package:rxdart/rxdart.dart';

class GlobalPermission {
  BehaviorSubject<List<PageMenuPermission>> _globalwarehouseMenu;
  BehaviorSubject<List<PageMenuPermission>> _globalmenuLocalDistribution;
  BehaviorSubject<List<PageMenuPermission>> _globalpackageMenu;
  BehaviorSubject<List<PageMenuPermission>> _globalmenuGeneral;
  int pageActive = 0;
  bool iSpageActive = false;
  bool iScheckluot = false;

  BehaviorSubject<List<PageMenuPermission>> get getItemWareHouseMenu =>
      _globalwarehouseMenu;

  set setwarehouseMenu(BehaviorSubject<List<PageMenuPermission>> value) =>
      _globalwarehouseMenu = value;

  BehaviorSubject<List<PageMenuPermission>> get getItemLocalDistributionMenu =>
      _globalmenuLocalDistribution;

  set setmenuLocalDistribution(
          BehaviorSubject<List<PageMenuPermission>> value) =>
      _globalmenuLocalDistribution = value;

  BehaviorSubject<List<PageMenuPermission>> get getItemPackageMenu =>
      _globalpackageMenu;

  set setpackageMenu(BehaviorSubject<List<PageMenuPermission>> value) =>
      _globalpackageMenu = value;

  BehaviorSubject<List<PageMenuPermission>> get getItemGeneralMenu =>
      _globalmenuGeneral;

  set setmenuGeneral(BehaviorSubject<List<PageMenuPermission>> value) =>
      _globalmenuGeneral = value;

  int get getpageActive => pageActive;

  set setpageActive(int value) => pageActive = value;

  bool get getIsPageActive => iSpageActive;

  set setIsPageActive(bool value) => iSpageActive = value;

  bool get getIscheckluot => iScheckluot;

  set setIscheckluot(bool value) => iScheckluot = value;

  static final GlobalPermission _translations =
      new GlobalPermission._internal();

  factory GlobalPermission() {
    return _translations;
  }

  GlobalPermission._internal();
}

GlobalPermission globalPermission = new GlobalPermission();
