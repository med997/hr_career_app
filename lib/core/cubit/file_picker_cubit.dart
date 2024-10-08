import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../model/dynamic_model.dart';
import '../util/enums.dart';



class FilePickerCubit extends Cubit<File?> {
  FilePickerCubit() : super(null);

  void addFile(File? file) {
    emit(null);
    // print(file);
    emit(file);
  }
}