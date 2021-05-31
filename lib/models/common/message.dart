import 'package:flutter/widgets.dart';

@immutable
class MessageNotifition {
  final String title;
  final String body;
  final int id;
  final String action;

  const MessageNotifition(
      {@required this.id,
      @required this.action,
      @required this.title,
      @required this.body});
}
