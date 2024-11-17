


import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Future<dynamic?> pickPdf(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  if (result != null) {
    if(kIsWeb){
      return result.files.first.bytes;
    }else{
      return result.files.first.path;
    }

  } else {
    return null;
  }
}