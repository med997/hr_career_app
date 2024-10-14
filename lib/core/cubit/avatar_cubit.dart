import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';


part 'avatar_state.dart';

class AvatarCubit extends Cubit<Uint8List?> {
  AvatarCubit() : super(null);
  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final Uint8List? fileBytes = result.files.first.bytes;
      final String fileName = result.files.first.name;
      if (fileBytes != null) {
        print('File Name: $fileName');
        emit(fileBytes);
      } else {
        print('Error: Could not Image.');
      }
    }
  }
}
