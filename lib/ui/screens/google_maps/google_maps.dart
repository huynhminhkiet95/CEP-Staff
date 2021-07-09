import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart' as currentLocation;
import 'package:qr_code_demo/ui/components/address_search.dart';
import 'package:qr_code_demo/utils/always_disabled_focus_node.dart';

class GoogleMapsScreen extends StatefulWidget {
  final LatLng coordinates;
  const GoogleMapsScreen({Key key, this.coordinates}) : super(key: key);

  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;
  TextEditingController _controller = TextEditingController();
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(10.8215188, 106.6275763));
  GoogleMapController mapController;

  String _currentAddress = '';
  Suggestion suggestion;
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  Set<Marker> markers = {};
  bool isForward = false;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  // Method for retrieving the current location
  _getCurrentLocation() async {
    var location = new currentLocation.Location();
    currentLocation.LocationData locationData = await location.getLocation();

    Future.delayed(Duration(milliseconds: 1000), () {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(locationData.latitude, locationData.longitude),
            zoom: 18.0,
          ),
        ),
      );
    });
  }

  animateCoordinatesAvailable() {
    Future.delayed(Duration(milliseconds: 1000), () {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
                widget.coordinates.latitude, widget.coordinates.longitude),
            zoom: 18.0,
          ),
        ),
      );
    });
  }

  // Method for retrieving the address
  _getAddress(LatLng latLng) async {
    try {
      var coordinates = new Coordinates(latLng.latitude, latLng.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);

      Address address = addresses[0];
      setState(() {
        _currentAddress = address.addressLine;
      });
    } catch (e) {
      print(e);
    }
  }

  static const LatLng _center =
      const LatLng(37.42796133580664, -122.085749655962);
  LatLng _lastMapPosition = _center;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutExpo);
    animation = Tween<double>(begin: 0, end: 170).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    if (widget.coordinates == null) {
      _getCurrentLocation();
    } else {
      animateCoordinatesAvailable();
    }
  }

  void _onCamMove(CameraPosition position) {
    _currentAddress = '';
    setState(() {});
    _lastMapPosition = position.target;
    print("_onCamMove: " +
        _lastMapPosition.latitude.toString() +
        "," +
        _lastMapPosition.longitude.toString());
  }

  // void _pinHere() {
  //   setState(() {
  //     markers.add(Marker(
  //       markerId: MarkerId(_lastMapPosition.toString()),
  //       position: _lastMapPosition,
  //       infoWindow: InfoWindow(
  //         title: 'Hello here',
  //         snippet: 'Super!',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            //  Map View
            GoogleMap(
              markers: Set<Marker>.from(markers),
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              onCameraMove: _onCamMove,
              onCameraIdle: () {
                _getAddress(_lastMapPosition);
              },
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              //polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                mapController.setMapStyle(
                    '[ { "elementType": "geometry", "stylers": [ { "color": "#ebe3cd" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#523735" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f1e6" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#c9b2a6" } ] }, { "featureType": "administrative.land_parcel", "elementType": "geometry.stroke", "stylers": [ { "color": "#dcd2be" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#ae9e90" } ] }, { "featureType": "landscape.natural", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#93817c" } ] }, { "featureType": "poi.park", "elementType": "geometry.fill", "stylers": [ { "color": "#a5b076" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#447530" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#f5f1e6" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#fdfcf8" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#f8c967" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#e9bc62" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [ { "color": "#e98d58" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry.stroke", "stylers": [ { "color": "#db8555" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#806b63" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "transit.line", "elementType": "labels.text.fill", "stylers": [ { "color": "#8f7d77" } ] }, { "featureType": "transit.line", "elementType": "labels.text.stroke", "stylers": [ { "color": "#ebe3cd" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "water", "elementType": "geometry.fill", "stylers": [ { "color": "#b9d3c2" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#92998d" } ] } ]');
              },
            ),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child:
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            // Provide an optional curve to make the animation feel smoother.
                            curve: Curves.fastOutSlowIn,
                            width: !isForward ? 50 : (width - 110),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: TextField(
                                      controller: _controller,
                                      cursorColor: Colors.black,
                                      onTap: () async {
                                        // generate a new token here

                                        var result = await showSearch(
                                            context: context,
                                            delegate: AddressSearch(),
                                            query: _controller.text);
                                        // This will change the text displayed in the TextField
                                        if (result != null) {
                                          setState(() {
                                            _controller.text =
                                                result.description;
                                          });
                                          suggestion = result;
                                          mapController.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                target: LatLng(
                                                  suggestion
                                                      .coordinates.latitude,
                                                  suggestion
                                                      .coordinates.longitude,
                                                ),
                                                zoom: 18.0,
                                              ),
                                            ),
                                          );
                                        } else {
                                          setState(() {
                                            _controller.text = '';
                                          });
                                        }
                                      },
                                      style: TextStyle(color: Colors.black),
                                      textInputAction: TextInputAction.search,
                                      focusNode: new AlwaysDisabledFocusNode(),
                                      enableInteractiveSelection: false,
                                      decoration: InputDecoration(
                                          hintText: "Search here...",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      if (!isForward) {
                                        animationController.forward();
                                        isForward = true;
                                      } else {
                                        animationController.reverse();
                                        isForward = false;
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Center(
                        child: Icon(
                          Icons.location_on,
                          size: 40.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                  ],
                ),
              ),
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Show the place input fields & button for
            // showing the route
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.white, // button color
                          child: InkWell(
                            splashColor: Colors.green.shade100, // inkwell color
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(
                                Icons.near_me,
                                color: Colors.blue,
                                size: 35,
                              ),
                            ),
                            onTap: () async {
                              _getCurrentLocation();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop({
                      'address': {
                        'coordinates': _lastMapPosition,
                        'descriptionAddress': _currentAddress
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 65,
                      //width: 260,
                      decoration: new BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white, width: 1.0),
                        // backgroundBlendMode: BlendMode.lighten,
                        borderRadius: new BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Lấy vị trí",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _currentAddress,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
