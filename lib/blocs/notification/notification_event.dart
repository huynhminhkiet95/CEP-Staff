import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

abstract class NotificationEvent extends BlocEvent {
  NotificationEvent();
}

class LoadNotificationEvent extends NotificationEvent {
  LoadNotificationEvent() : super();
}

class UpdateNotification extends NotificationEvent {
  String reqIds;
  String status;
  UpdateNotification(this.reqIds, this.status) : super();
}

class DeleteNotification extends NotificationEvent {
  String reqIds;
  DeleteNotification(this.reqIds) : super();
}
