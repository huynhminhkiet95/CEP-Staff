import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

class SettingState extends BlocState {
  final bool isLoading;
  final bool isLoadingSaveData;
  SettingState({this.isLoading, this.isLoadingSaveData});

  factory SettingState.init() {
    return SettingState(isLoading: false, isLoadingSaveData: false);
  }

  factory SettingState.updateLoading(bool isLoading) {
    return SettingState(
      isLoading: isLoading,
    );
  }

  factory SettingState.updateLoadingSaveData(bool isLoadingSaveData) {
    return SettingState(
      isLoadingSaveData: isLoadingSaveData,
    );
  }
}
