import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:google_maps_webservice/places.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  List<Address> address;
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
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        color: Colors.grey,
        onPressed: () {
          query = '';
        },
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
      icon: Icon(Icons.arrow_back),
      color: Colors.grey,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: FutureBuilder(
          future: getAddress(query),
          builder: (context, snapshot) {
            address = snapshot.data;

            if (address != null && address.length > 0) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var subAddress = address[index].addressLine.split(',');
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
                                  color: Colors.black,
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
                              color: Colors.blue,
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
                  child: Container(color: Colors.white, child: null));
            }
          }),
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

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return Container();
    } else if (query.length > 3) {
      return Container(
        color: Colors.white,
        child: FutureBuilder(
            future: getAddress(query),
            builder: (context, snapshot) {
              address = snapshot.data;
              if (address != null && address.length > 0) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var subAddress = address[index].addressLine.split(',');
                    Suggestion suggestion = new Suggestion();

                    suggestion.coordinates = address[index].coordinates;
                    suggestion.description = query;
                    return ListTile(
                      // we will display the data returned from our future here
                      title: Text(
                        subAddress.first,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        address[index].addressLine,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      leading: Icon(Icons.location_city),
                      onTap: () {
                        close(context, suggestion);
                      },
                    );
                  },
                  itemCount: address.length,
                );
              } else {
                return SizedBox.expand(
                    child: Container(
                        color: Colors.white, child: Text('No data...')));
              }
            }),
      );
    } else {
      return SizedBox.expand(
          child: Container(color: Colors.white, child: Text('Loading...')));
    }
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
