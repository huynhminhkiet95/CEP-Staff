import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/config/constants.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:location/location.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationBloc
    extends BlocEventStateBase<LocationEvent, LocationDataState> {
  final SharePreferenceService sharePreferenceService;
  LocationBloc(this.sharePreferenceService);

  Location location = new Location();

  @override
  Stream<LocationDataState> eventHandler(
      LocationEvent event, LocationDataState currentState) async* {
    if (event is GetLocation) {}

    LocationData currentLocation;
    var location = new Location();

    try {
      currentLocation = await location.getLocation();
      yield LocationDataState(
          currentLocation.latitude,
          currentLocation.longitude,
          currentLocation.accuracy,
          currentLocation.altitude,
          currentLocation.speed,
          currentLocation.speedAccuracy,
          currentLocation.heading,
          currentLocation.time);
    } catch (e) {
      currentLocation = null;
    }

    location.onLocationChanged().listen((LocationData currentLocation) {
      sharePreferenceService.share
          .setDouble(KeyConstants.latitude, currentLocation.latitude);
      sharePreferenceService.share
          .setDouble(KeyConstants.longitude, currentLocation.longitude);
      LocationDataState(
          currentLocation.latitude,
          currentLocation.longitude,
          currentLocation.accuracy,
          currentLocation.altitude,
          currentLocation.speed,
          currentLocation.speedAccuracy,
          currentLocation.heading,
          currentLocation.time);
    });
  }
}
