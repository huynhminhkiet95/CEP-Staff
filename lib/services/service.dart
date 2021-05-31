import 'package:qr_code_demo/services/documentService.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_demo/httpProvider/HttpProviders.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  final SharedPreferences sharedPrefs;
  final HttpBase httpBase;
  final CommonService commonService;
  final SharePreferenceService sharePreferenceService;
  final DocumentService documentService;
  //final GoogleMapService googleMapService;

  Services(this.sharedPrefs, this.httpBase, this.commonService,
      this.sharePreferenceService, this.documentService);

  static Future<Services> initialize() async {
    // GET instance here and inject
    final sharedPrefs = await SharedPreferences.getInstance();
    final sharePreferenceService = new SharePreferenceService(sharedPrefs);
    final httpBase = new HttpBase();
    final commonService = new CommonService(httpBase);
    final documentService = new DocumentService(httpBase);
    // final googleMapService = new GoogleMapService();

    await sharePreferenceService.getServerInfo();
    await sharePreferenceService.getDriverProfile();
    await sharePreferenceService.getToken();
    await sharePreferenceService.getUserName();
    await sharePreferenceService.getPassword();
    await sharePreferenceService.getAuthenLocal();
    await sharePreferenceService.getCumId();
    await sharePreferenceService.getCumIdOfCommunityDevelopment();
    await sharePreferenceService.getRememberUser();
    await sharePreferenceService.getIsRemember();
    await sharePreferenceService.getUserInfo();
    await sharePreferenceService.getUserRole();
    await sharePreferenceService.getMetadata();
    await sharePreferenceService.getSurveyList();

    return Services(sharedPrefs, httpBase, commonService,
        sharePreferenceService, documentService);
  }

  static Services of(BuildContext context) {
    final provider = context
        .ancestorInheritedElementForWidgetOfExactType(ServicesProvider)
        .widget as ServicesProvider;
    return provider.services;
  }
}

class ServicesProvider extends InheritedWidget {
  final Services services;

  ServicesProvider({Key key, this.services, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(ServicesProvider old) {
    if (services != old.services) {
      throw Exception('Services must be constant!');
    }
    return false;
  }
}
