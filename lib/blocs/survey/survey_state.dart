import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

class SurveyState extends BlocState {
  final bool isLoading;
  final bool isLoadingSaveData;
  SurveyState({this.isLoading, this.isLoadingSaveData});

  factory SurveyState.init() {
    return SurveyState(isLoading: false, isLoadingSaveData: false);
  }

  factory SurveyState.updateLoading(bool isLoading) {
    return SurveyState(
      isLoading: isLoading,
    );
  }

  factory SurveyState.updateLoadingSaveData(bool isLoadingSaveData) {
    return SurveyState(
      isLoadingSaveData: isLoadingSaveData,
    );
  }
}
