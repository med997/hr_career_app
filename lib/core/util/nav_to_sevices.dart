import 'dart:io';

import 'package:flutter/foundation.dart';
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

navToWhatsapp(String number) async {
  String contact = number;
  String text = '';
  String androidUrl = "whatsapp://send?phone=$contact&text=$text";
  String iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";
  String webUrl =
      'https://api.whatsapp.com/send/?phone=$contact&text=Write here!';

  try {
    if (kIsWeb) {
      if (await canLaunchUrl(Uri.parse(webUrl))) {
        await launchUrl(Uri.parse(webUrl),
            mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(iosUrl))) {
        await launchUrl(Uri.parse(iosUrl));
      }
    } else {
      if (await canLaunchUrl(Uri.parse(androidUrl))) {
        await launchUrl(Uri.parse(androidUrl));
      }
    }
  } catch (e) {
    print('Error launching WhatsApp: $e');
    // Fallback to WhatsApp Web if there's an error
    await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
  }
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
