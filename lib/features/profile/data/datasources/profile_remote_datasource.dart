import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileModel> getUser();
  Future<ProfileModel> getUserByUuid(String uuid);
}

class ProfileRemoteDatasourceImp extends ProfileRemoteDatasource {
  final SupabaseClient client;


  ProfileRemoteDatasourceImp({ required this.client});

  @override
  Future<ProfileModel> getUser() async {
    try {
      final data = await client.from('profile').select();

      if (data.isNotEmpty) {
        return ProfileModel.fromJson(data[0]);
      } else {
        throw ServerException();
      }
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> getUserByUuid(String uuid)async {

    try {
      final data = await client.from('profiles').select('*').eq('id', uuid).limit(1);

      print(data[0].toString());
      if (data.isNotEmpty) {
        return ProfileModel.fromJson(data[0]);
      } else {
        throw const ServerException();
      }
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: error.message);
    }
  }
}
