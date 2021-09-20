import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr_code_demo/ui/navigation/slide_route.dart';
import 'package:qr_code_demo/ui/screens/Home/dashboard.dart';
import 'package:qr_code_demo/ui/screens/Login/loginPage.dart';
import 'package:qr_code_demo/ui/screens/Login/signup.dart';
import 'package:qr_code_demo/ui/screens/calculation_money/calculation_money.dart';
import 'package:qr_code_demo/ui/screens/community_development/community_development.dart';
import 'package:qr_code_demo/ui/screens/community_development/community_development_detail.dart';
import 'package:qr_code_demo/ui/screens/community_development/community_development_detail_fake.dart';
import 'package:qr_code_demo/ui/screens/delete_data/delete_data.dart';
import 'package:qr_code_demo/ui/screens/dept_collection/dept_collection.dart';
import 'package:qr_code_demo/ui/screens/downloadData/download_main.dart';
import 'package:qr_code_demo/ui/screens/error/error.dart';
import 'package:qr_code_demo/ui/screens/google_maps/google_maps.dart';
import 'package:qr_code_demo/ui/screens/personal_information_user/personal_information_user.dart';
import 'package:qr_code_demo/ui/screens/personal_information_user/personal_information_user_update.dart';
import 'package:qr_code_demo/ui/screens/personal_information_user/qr_scanner.dart';
import 'package:qr_code_demo/ui/screens/personal_information_user/personal_information_user_detail.dart';
import 'package:qr_code_demo/ui/screens/profile/language.dart';
import 'package:qr_code_demo/ui/screens/profile/setting.dart';
import 'package:qr_code_demo/ui/screens/profile/user_profile.dart';
import 'package:qr_code_demo/ui/screens/survey/survey.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_provider.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_bloc.dart';
import 'package:qr_code_demo/route.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/ui/decision_page_no_business.dart';
import 'package:qr_code_demo/ui/initialization_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qr_code_demo/ui/screens/survey/survey_detail.dart';
import 'package:qr_code_demo/ui/screens/survey/survey_detail_fake.dart';
import 'models/common/message.dart';
import 'models/download_data/comboboxmodel.dart';
import 'ui/screens/Login/welcomePage.dart';
import 'package:qr_code_demo/notifications/local_notications_helper.dart';

// extension ExtendedString on String {
//   bool get isValidName {
//     return !this.contains(new RegExp(r'[0–9]'));
//   }
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await allTranslations.init();
  final services = await Services.initialize();
  // await PermissionHandler()
  //     .requestPermissions([PermissionGroup.camera, PermissionGroup.microphone]);

  runApp(ServicesProvider(services: services, child: Application()));
}

class Application extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<Application> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));
    flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);

    _firebaseMessaging.configure(
      onMessage: (message) async {
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });
        showIconNotification(
          context,
          flutterLocalNotificationsPlugin,
          icon: Image.asset('assets/logo/CEP-logo_lauch_1.png'),
          title: message["notification"]["title"],
          body: message["notification"]["body"],
          id: 41,
        );
      },
      onResume: (message) async {
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });
        showIconNotification(
          context,
          flutterLocalNotificationsPlugin,
          icon: Image.asset('assets/logo/CEP-logo_lauch.png'),
          title: 'SmallImageTitle',
          body: 'SmallImageBody',
          id: 40,
        );
      },
    );

    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('Hello');
    });
    _firebaseMessaging.getToken().then((token) {
      print(token); // Print the Token in Console
    });
    final services = Services.of(context);
    //globalUser
    authenticationBloc = new AuthenticationBloc(
        services.commonService, services.sharePreferenceService);
    //DBProvider.db.checkColumn();
    // Android-specific code
  }

  Future displayNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelid', 'flutterfcm', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'hello',
    );
  }

  @override
  void dispose() {
    authenticationBloc.dispose();
    super.dispose();
  }

  Widget buildMessage(MessageNotifition message) => ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: authenticationBloc,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
          fontFamily: 'SourceSansPro',
          brightness: Brightness.light,
          //scaffoldBackgroundColor: ColorConstants.cepColorBackground,
          accentColor: Colors.white,
          textSelectionHandleColor: Colors.black,
          primaryColor: Colors.blue,
          cardColor: Colors.white,
          //highlightColor: ColorConstants.cepColorBackground,'
        ),

        darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.black,
            brightness: Brightness.dark,
            accentColor: Colors.black,
            textSelectionHandleColor: Colors.white,
            accentIconTheme: IconThemeData(color: Colors.black),
            scaffoldBackgroundColor: Colors.black54,
            cardColor: Colors.black,
            highlightColor: Colors.white),

        themeMode: ThemeMode.light,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: allTranslations.supportedLocales(),
        title: allTranslations.text('app_title'),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/decision':
              return new MyCustomRoute(
                builder: (_) => new DecisionPage(),
                settings: settings,
              );
              break;
            case '/login':
              return SlideLeftRoute(page: LoginPage());
            case '/menudashboard':
              return SlideLeftRoute(page: MenuDashboardPage());
            case '/welcomeLogin':
              return SlideBottomToTopRoute(page: WelcomePage());
            case '/home':
              return new MyCustomRoute(
                builder: (_) => new MenuDashboardPage(),
                settings: settings,
              );

            case 'error':
              return SlideLeftRoute(page: ErrorScreen());
              break;

            case 'survey':
              return SlideLeftRoute(page: SurveyScreen());
              break;

            case 'deletedata':
              return SlideLeftRoute(page: DeleteDataScreen());
              break;

            case 'personalinforuserdetail':
              final Map<String, Object> arguments = settings.arguments;
              if (arguments == null) {
                return SlideLeftRoute(page: PersonalInformationUserDetail());
              } else {
                return SlideLeftRoute(
                    page: PersonalInformationUserDetail(
                  customerCode: arguments['customerCode'] ?? null,
                  branchID: arguments['branchID'].toString(),
                ));
              }
              break;

            case 'personalinforuserupdate':
              final Map<String, Object> arguments = settings.arguments;
              return SlideLeftRoute(
                  page: PersonalInformationUserUpdate(
                      customerInfo: arguments['customerInfo']));
              break;
            case 'deptcollection':
              return SlideLeftRoute(page: DeptCollectionScreen());
              break;

            case 'personalinforuser':
              return SlideLeftRoute(page: PersonalInformationUser());
              break;

            case 'qrcode':
              return SlideLeftRoute(page: QRScannerScreen());
              break;

            case 'userprofile':
              return SlideLeftRoute(page: ProfilePageDesign());
              break;

            case 'surveydetail':
              final Map<String, Object> arguments = settings.arguments;
              return SlideTopRoute(
                  page: SurveyDetailScreen(
                id: arguments['id'],
                listCombobox: arguments['metadata'],
                surveyInfo: arguments['surveydetail'],
                listSurveyHistory: arguments['surveyhistory'],
              ));
              break;
            case 'surveydetailfake':
              return SlideTopRoute(page: SurveyDetailFakeScreen());
              break;

            case 'download':
              final Map<String, Object> arguments = settings.arguments;
              if (arguments == null) {
                return SlideLeftRoute(page: DownloadScreen());
              } else {
                return SlideLeftRoute(
                    page: DownloadScreen(
                  selectedIndex: arguments['selectedIndex'],
                ));
              }
              break;
            case 'comunitydevelopment':
              return SlideLeftRoute(page: CommunityDevelopmentScreen());
              break;
            case 'comunitydevelopmentdetail':
              final Map<String, Object> arguments = settings.arguments;
              return SlideTopRoute(
                  page: CommunityDevelopmentDetail(
                khachHang: arguments['khachhang'],
                listCombobox: arguments['metadata'],
              ));
              break;
            case 'comunitydevelopmentdetailfake':
              return SlideTopRoute(page: CommunityDevelopmentDetailFake());
              break;

            case 'setting':
              return SlideLeftRoute(page: SettingsScreen());
            case 'language':
              return SlideBottomToTopRoute(page: LanguagesScreen());
            case 'calculation':
              return SlideLeftRoute(page: CalculationMoney());
            case 'signup':
              return SlideLeftRoute(page: SignUpPage());

            case 'googlemaps':
              final Map<String, Object> arguments = settings.arguments;
              return SlideLeftRoute(
                  page:
                      GoogleMapsScreen(coordinates: arguments['coordinates']));

            default:
              return new MyCustomRoute(
                builder: (_) => new ErrorScreen(),
                settings: settings,
              );
              break;
          }
        },
        // onUnknownRoute: (RouteSettings settings) {
        //   if (settings.name != null) {
        //     SlideLeftRoute(page: ErrorScreen());
        //   }

        // },
        home: InitializationPage(),
      ),
    );
  }

  Future onSelectNotification(String payload) =>
      Navigator.pushNamed(navigatorKey.currentContext, 'userprofile');
}
