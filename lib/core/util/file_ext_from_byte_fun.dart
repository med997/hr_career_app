import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

String? getFileExtension(Uint8List data) {
  if (data.length < 4) return null; // Not enough data

  // Check for common file signatures
  if (data[0] == 0x89 && data[1] == 0x50 && data[2] == 0x4E && data[3] == 0x47) {
    return 'png'; // PNG
  } else if (data[0] == 0xFF && data[1] == 0xD8) {
    return 'jpg'; // JPEG
  } else if (data[0] == 0x47 && data[1] == 0x49 && data[2] == 0x46) {
    return 'gif'; // GIF
  } else if (data[0] == 0x25 && data[1] == 0x50 && data[2] == 0x44 && data[3] == 0x46) {
    return 'pdf'; // PDF
  } else if (data[0] == 0x42 && data[1] == 0x4D) {
    return 'bmp'; // BMP
  }

  return null; // Unknown type
}
String getBase64FileExtension(String base64String) {
  switch (base64String.characters.first) {
    case '/':
      return 'jpeg';
    case 'i':
      return 'png';
    case 'R':
      return 'gif';
    case 'U':
      return 'webp';
    case 'J':
      return 'pdf';
    default:
      return 'unknown';
  }
}