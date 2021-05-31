import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';

abstract class LocationEvent extends BlocEvent {
  LocationEvent();
}

class GetLocation extends LocationEvent {
  GetLocation();
}
