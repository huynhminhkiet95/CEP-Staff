import 'dart:convert';

import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/models/common/notification.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:rxdart/rxdart.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc
    extends BlocEventStateBase<NotificationEvent, NotificationState> {
  final SharePreferenceService sharePreferenceService;
  final CommonService commonService;

  NotificationBloc(this.sharePreferenceService, this.commonService)
      : super(initialState: NotificationState.init());

  var _getNotifications = BehaviorSubject<List<NotificationModel>>();
  Stream<List<NotificationModel>> get getNotifications => _getNotifications;

  @override
  void dispose() {
    _getNotifications?.close();
    super.dispose();
  }

  @override
  Stream<NotificationState> eventHandler(
      NotificationEvent event, NotificationState state) async* {
    if (event is LoadNotificationEvent) {
      yield NotificationState.updateLoading(true);

      //var notifications = await DBProvider.db.getAllNotifications(globalUser.getUserId);
      // var notifications = await commonService.getNotifications(
      //     globalUser.getUserId, globalUser.getSystemId, "NOTIFICATION");

      // if (notifications != null && notifications.statusCode == 200) {
      //   var dataJson = json.decode(notifications.body);
      //   var tripTodoJson = dataJson.cast<Map<String, dynamic>>() as List;
      //   if (tripTodoJson.length > 0) {
      //     var checkLists = tripTodoJson
      //         .map<NotificationModel>(
      //             (json) => NotificationModel.fromJson(json))
      //         .toList();
      //     checkLists.sort((a, b) => b.id.compareTo(a.id));
      //     if (!_getNotifications.isClosed)
      //       _getNotifications.sink.add(checkLists);
      //   } else {
      //     if (_getNotifications?.isClosed != true) {
      //       _getNotifications.sink.add(null);
      //     }
      //   }
      // }
      yield NotificationState.updateLoading(false);
    }

    if (event is UpdateNotification) {
      yield NotificationState.updateLoading(true);

      //await DBProvider.db.updateNotification(event.data);
      // var notifications = await commonService.updateNotifications(
      //     globalUser.getUserId, event.reqIds, event.status);

      // if (notifications != null && notifications.statusCode == 200) {
      //   var dataJson = json.decode(notifications.body);
      //   if (dataJson == "true") {}
      // }
      yield NotificationState.updateLoading(false);
    }

    if (event is DeleteNotification) {
      yield NotificationState.updateLoading(true);
      //await DBProvider.db.updateNotification(event.data);
      // var notifications = await commonService.deleteNotifications(event.reqIds);

      // if (notifications != null && notifications.statusCode == 200) {
      //   // var dataJson = json.decode(notifications.body);
      // }
      yield NotificationState.updateLoading(false);
    }
  }
}
