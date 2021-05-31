import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

class DeleteDataState extends BlocState {
  final bool isLoading;
  final bool isLoadingSaveData;
  DeleteDataState({this.isLoading, this.isLoadingSaveData});

  factory DeleteDataState.init() {
    return DeleteDataState(isLoading: false, isLoadingSaveData: false);
  }

  factory DeleteDataState.updateLoading(bool isLoading) {
    return DeleteDataState(
      isLoading: isLoading,
    );
  }

  factory DeleteDataState.updateLoadingSaveData(bool isLoadingSaveData) {
    return DeleteDataState(
      isLoadingSaveData: isLoadingSaveData,
    );
  }
}
