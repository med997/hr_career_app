import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<bool> navToCall(String phoneNumber) {
  return launchUrlString("tel:$phoneNumber");
}

Future<bool> navToEmail(String email) {
  return launchUrlString("mailto:$email");
}

Future<bool> navToWebsite(String website) {
  return launchUrlString("https:$website");
}

class MapUtils {
  MapUtils._();

  static Future<void> navToMap(String latitude, String longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
