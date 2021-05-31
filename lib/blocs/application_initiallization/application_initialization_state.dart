import 'package:flutter/material.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

class ApplicationInitializationState extends BlocState {
  ApplicationInitializationState({
    @required this.isInitialized,
    this.isInitializing: false,
    this.progress: 0,
  });

  final bool isInitialized;
  final bool isInitializing;
  final double progress;

  factory ApplicationInitializationState.notInitialized() {
    return ApplicationInitializationState(
      isInitialized: false,
    );
  }

  factory ApplicationInitializationState.progressing(double progress) {
    return ApplicationInitializationState(
      isInitialized: progress == 100,
      isInitializing: true,
      progress: progress,
    );
  }

  factory ApplicationInitializationState.initialized() {
    return ApplicationInitializationState(
      isInitialized: true,
      progress: 100,
    );
  }
}
