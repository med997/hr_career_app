
 import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

Future<String?> pickImage(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png'],
  );
  if (result != null) {
    return result.files.first.path;
  } else {
    return null;
  }
}