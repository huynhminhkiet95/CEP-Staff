import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

Future<NotificationDetails> _imageAndIcon(
    BuildContext context, Image picture, Image icon) async {
  // final iconPath = await saveImage(context, icon);
  //final picturePath = await saveImage(context, picture);//

  final bigPictureStyleInformation = BigPictureStyleInformation(
    'https://www.cep.org.vn/themes/default/images/cep-large-icon-logo-intro.png',
    BitmapSource.FilePath,
    largeIcon:
        'https://www.cep.org.vn/themes/default/images/cep-large-icon-logo-intro.png',
    largeIconBitmapSource: BitmapSource.FilePath,
  );

  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'big text channel id',
    'big text channel name',
    'big text channel description',
    style: AndroidNotificationStyle.BigPicture,
    styleInformation: bigPictureStyleInformation,
  );
  return NotificationDetails(androidPlatformChannelSpecifics, null);
}

Future showIconAndImageNotification(
  BuildContext context,
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required Image picture,
  @required Image icon,
  int id = 0,
}) async =>
    notifications.show(
        id, title, body, await _imageAndIcon(context, picture, icon));

Future<NotificationDetails> _image(BuildContext context, Image picture) async {
  //final picturePath = await saveImage(context, picture);

  final bigPictureStyleInformation = BigPictureStyleInformation(
    'https://www.cep.org.vn/themes/default/images/cep-large-icon-logo-intro.png',
    BitmapSource.FilePath,
  );

  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'big text channel id',
    'big text channel name',
    'big text channel description',
    style: AndroidNotificationStyle.BigPicture,
    styleInformation: bigPictureStyleInformation,
  );
  return NotificationDetails(androidPlatformChannelSpecifics, null);
}

Future showImageNotification(
  BuildContext context,
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required Image picture,
  int id = 0,
}) async =>
    notifications.show(id, title, body, await _image(context, picture));

Future<NotificationDetails> _icon(BuildContext context, Image icon) async {
  final iconPath = await saveImage(context, icon);

  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'big text channel id',
    'big text channel name',
    'big text channel description',
    largeIcon: iconPath,
    largeIconBitmapSource: BitmapSource.FilePath,
  );
  return NotificationDetails(androidPlatformChannelSpecifics, null);
}

Future showIconNotification(
  BuildContext context,
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required Image icon,
  int id = 0,
}) async =>
    notifications.show(id, title, body, await _icon(context, icon));

NotificationDetails get _noSound {
  final androidChannelSpecifics = AndroidNotificationDetails(
      'channelid', 'flutterfcm', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  final iOSChannelSpecifics = IOSNotificationDetails(presentSound: false);

  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showSilentNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  int id = 0,
}) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _noSound);

NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: true,
    autoCancel: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showOngoingNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  int id = 0,
}) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _ongoing);

Future _showNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  int id = 0,
}) =>
    notifications.show(id, title, body, type);

Future<String> saveImage(BuildContext context, Image image) {
  final completer = Completer<String>();

  image.image
      .resolve(new ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo imageInfo, bool _) async {
    final byteData =
        await imageInfo.image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData.buffer.asUint8List();

    final fileName = pngBytes.hashCode;
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(pngBytes);
    completer.complete(filePath);
  }));

  return completer.future;
}
