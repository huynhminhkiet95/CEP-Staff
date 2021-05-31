import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String address) async {
    address = address.replaceAll(',', ' ');
    if (address.indexOf('P.') > 0) {
      address = address.replaceAll('P.', 'Phường ');
    }
    address = address.replaceAll('.', ' ');
    if (address.indexOf('Q.') > 0) {
      address = address.replaceAll('Q.', 'Quận ');
    }
    
    var location = new Location();
    LocationData currentLocation = await location.getLocation();
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&travelmode=driving&origin=${currentLocation.latitude},${currentLocation.longitude}&destination=$address';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
