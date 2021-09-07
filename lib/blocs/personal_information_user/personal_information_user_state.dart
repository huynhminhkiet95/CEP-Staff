import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

class PersonalInformationUserState extends BlocState {
  final bool isLoading;
  final bool isLoadingSaveData;
  PersonalInformationUserState({this.isLoading, this.isLoadingSaveData});

  factory PersonalInformationUserState.init() {
    return PersonalInformationUserState(
        isLoading: false, isLoadingSaveData: false);
  }

  factory PersonalInformationUserState.updateLoading(bool isLoading) {
    return PersonalInformationUserState(
      isLoading: isLoading,
    );
  }

  factory PersonalInformationUserState.updateLoadingSaveData(
      bool isLoadingSaveData) {
    return PersonalInformationUserState(
      isLoadingSaveData: isLoadingSaveData,
    );
  }
}
