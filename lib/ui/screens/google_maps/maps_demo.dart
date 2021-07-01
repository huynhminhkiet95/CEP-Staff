import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsDemoPage extends StatefulWidget {
  MapsDemoPage({
    Key key,
  }) : super(key: key);

  @override
  _MapsDemoState createState() => _MapsDemoState();
}

class _MapsDemoState extends State<MapsDemoPage> {
  GoogleMapController myController;
  // Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center =
      const LatLng(37.42796133580664, -122.085749655962);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;

  static final CameraPosition initCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void _pinHere() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Hello here',
          snippet: 'Super!',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCamMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              myController = controller;
            },
            initialCameraPosition: initCameraPosition,
            compassEnabled: true,
            markers: _markers,
            onCameraMove: _onCamMove,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
          ),
          SizedBox(
            child: Center(
              child: Icon(
                Icons.add_location,
                size: 40.0,
                color: Colors.pink[600],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.gps_fixed,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RawMaterialButton(
                    onPressed: () => _pinHere(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.add_location,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ))
            ],
          )
        ],
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await myController;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
