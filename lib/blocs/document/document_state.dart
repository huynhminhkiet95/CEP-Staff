import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

class DocumentState extends BlocState {
  final bool isLoading;
  final bool isSuccess;
  DocumentState({this.isLoading, this.isSuccess});

  factory DocumentState.init() {
    return DocumentState(isLoading: true);
  }

  factory DocumentState.updateLoading(bool isLoading) {
    return DocumentState(
      isLoading: isLoading,
    );
  }
  factory DocumentState.updateStatus(bool isSuccess) {
    return DocumentState(isSuccess: isSuccess);
  }
}
