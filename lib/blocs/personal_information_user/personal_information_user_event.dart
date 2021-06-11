import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/models/personal_information_user/update_information_user.dart';

abstract class PersonalInformationUserEvent extends BlocEvent {
  PersonalInformationUserEvent();
}

class UpdatePersonalInformationUserEvent extends PersonalInformationUserEvent {
  final UpdateInformationUser updateInformationUser;
  final BuildContext context;
  UpdatePersonalInformationUserEvent(this.context, this.updateInformationUser)
      : super();
}
