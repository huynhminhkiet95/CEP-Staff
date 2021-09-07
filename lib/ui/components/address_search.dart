import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/database/DBProvider.dart';
import 'package:qr_code_demo/models/googlemaps/addressgooglemaps.dart';
//import 'package:google_maps_webservice/places.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  List<Address> address;
  List<AddressGoogleMaps> listAddressGoogleMaps;
  //List<Prediction> data;
  Coordinates coordinates;

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.black,
          //new AppBar color
          elevation: 10,
        ),
        primaryColor: Colors.white,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.grey[850],
          ),
        ),
        scaffoldBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        accentColor: Colors.white);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      InkWell(
        onTap: () {
          query = '';
        },
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey)),
          child: Icon(
            Icons.close,
            size: 15,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(
        width: 20,
      )
    ];
  }

  @override
  TextStyle searchFieldStyle = TextStyle(color: Colors.grey, fontSize: 16);

  @override
  String searchFieldLabel = "Search here...";

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(
        Icons.arrow_back_ios,
        size: 15,
      ),
      color: Colors.grey,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == '') {
      return buildBodyHistorySearch();
    } else {
      return buildBodySearchAddress();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return buildBodyHistorySearch();
    } else if (query.length > 3) {
      return buildBodySearchAddress();
    } else {
      return SizedBox.expand(
          child: Container(color: Colors.white, child: Text('Loading...')));
    }
  }

  Widget buildBodyHistorySearch() {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 30,
              child: Center(
                  child: Text(
                "Lịch sử tìm kiếm",
                style: TextStyle(
                    color: ColorConstants.cepColorBackground,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: getAddressSearchHistory(query),
                    builder: (context, snapshot) {
                      listAddressGoogleMaps = snapshot.data;

                      if (listAddressGoogleMaps != null &&
                          listAddressGoogleMaps.length > 0) {
                        return buildListViewHistoryAddress();
                      } else {
                        return SizedBox.expand(child: Container(child: null));
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBodySearchAddress() {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 30,
              child: Center(
                  child: Text(
                "Địa chỉ được tìm thấy",
                style: TextStyle(
                    color: ColorConstants.cepColorBackground,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: getAddress(query),
                    builder: (context, snapshot) {
                      address = snapshot.data;

                      if (address != null && address.length > 0) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            var subAddress =
                                address[index].addressLine.split(',');
                            Suggestion suggestion = new Suggestion();

                            suggestion.coordinates = address[index].coordinates;
                            suggestion.description = query;
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    color: Colors.grey[300],
                                    // padding: EdgeInsets.only(
                                    //     right: 10, left: 10, top: 10, bottom: 10),
                                    child: ListTile(
                                      // we will display the data returned from our future here
                                      title: Text(
                                        subAddress.first,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: ColorConstants
                                                .cepColorBackground,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        address[index].addressLine,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      leading: Icon(
                                        Icons.location_city,
                                        color:
                                            ColorConstants.cepColorBackground,
                                      ),
                                      onTap: () {
                                        close(context, suggestion);
                                      },
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                  height: 1,
                                )
                              ],
                            );
                          },
                          itemCount: address.length,
                        );
                      } else {
                        return SizedBox.expand(
                            child: ModalProgressHUD(
                                color: Colors.grey,
                                inAsyncCall: true,
                                progressIndicator: RefreshProgressIndicator(
                                  backgroundColor: Color(0xff223f92),
                                ),
                                child: Container(child: null)));
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListViewHistoryAddress() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemBuilder: (context, index) {
        double latitude = double.parse(
            listAddressGoogleMaps[index].coordinates.split(',').first);
        double longitude = double.parse(
            listAddressGoogleMaps[index].coordinates.split(',').last);
        Coordinates coordinates = new Coordinates(latitude, longitude);
        var subAddress = listAddressGoogleMaps[index].addressLine.split(',');
        Suggestion suggestion = new Suggestion();
        suggestion.coordinates = coordinates;
        suggestion.description = query;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                color: Colors.grey[300],
                // padding: EdgeInsets.only(
                //     right: 10, left: 10, top: 10, bottom: 10),
                child: ListTile(
                  // we will display the data returned from our future here
                  title: Text(
                    subAddress.first,
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.cepColorBackground,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    listAddressGoogleMaps[index].addressLine,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  leading: Icon(Icons.history_rounded,
                      color: ColorConstants.cepColorBackground),
                  onTap: () {
                    close(context, suggestion);
                  },
                ),
              ),
            ),
            Divider(
              color: Colors.grey[500],
              height: 1,
            )
          ],
        );
      },
      itemCount: listAddressGoogleMaps.length,
    );
  }

  Future<dynamic> getAddress(String query) async {
    List<Address> address;
    try {
      address = await Geocoder.local.findAddressesFromQuery(query);
    } catch (e) {
      address = new List<Address>();
    }
    return address;
  }

  Future<List<AddressGoogleMaps>> getAddressSearchHistory(String query) async {
    List<AddressGoogleMaps> listAddressGoogleMaps;
    try {
      listAddressGoogleMaps =
          await DBProvider.db.getHistorySearchAddressGoogleMap();
      listAddressGoogleMaps
          .sort((a, b) => b.searchDate.compareTo(a.searchDate));
      print("OK");
    } catch (e) {
      listAddressGoogleMaps = new List<AddressGoogleMaps>();
    }
    return listAddressGoogleMaps;
  }

  // getAddress() async {
  //   _place = await _places.queryAutocomplete('102 Quang Trung');
  //   if (_place.status == "OK") {
  //     data = _place.predictions;
  //   }
  // }
}

class Suggestion {
  Coordinates coordinates;
  String description;

  Suggestion({this.coordinates, this.description});
}
