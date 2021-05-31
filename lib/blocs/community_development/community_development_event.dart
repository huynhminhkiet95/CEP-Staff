import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:flutter/material.dart';

abstract class CommunityDevelopmentEvent extends BlocEvent {
  CommunityDevelopmentEvent();
}

class LoadCommunityDevelopmentEvent extends CommunityDevelopmentEvent {
  LoadCommunityDevelopmentEvent() : super();
}

class SearchCommunityDevelopmentEvent extends CommunityDevelopmentEvent {
  final String cumID;
  SearchCommunityDevelopmentEvent(this.cumID) : super();
}

class UpdateCommunityDevelopmentEvent extends CommunityDevelopmentEvent {
  final KhachHang khachHang;
  final BuildContext context;
  UpdateCommunityDevelopmentEvent(this.context, this.khachHang) : super();
}

class UpdateCommunityDevelopmentToServerEvent
    extends CommunityDevelopmentEvent {
  final KhachHang khachHang;
  final BuildContext context;
  UpdateCommunityDevelopmentToServerEvent(this.context, this.khachHang)
      : super();
}
