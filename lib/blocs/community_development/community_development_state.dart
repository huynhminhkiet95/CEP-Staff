import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

class CommunityDevelopmentState extends BlocState {
  final bool isLoading;
  final bool isLoadingSaveData;
  CommunityDevelopmentState({this.isLoading, this.isLoadingSaveData});

  factory CommunityDevelopmentState.init() {
    return CommunityDevelopmentState(
        isLoading: false, isLoadingSaveData: false);
  }

  factory CommunityDevelopmentState.updateLoading(bool isLoading) {
    return CommunityDevelopmentState(
      isLoading: isLoading,
    );
  }

  factory CommunityDevelopmentState.updateLoadingSaveData(
      bool isLoadingSaveData) {
    return CommunityDevelopmentState(
      isLoadingSaveData: isLoadingSaveData,
    );
  }
}
