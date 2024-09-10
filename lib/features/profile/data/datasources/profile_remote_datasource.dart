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
}

class ProfileRemoteDatasourceImp extends ProfileRemoteDatasource {
  final SupabaseClient client;
  final NetworkInfo networkInfo;

  ProfileRemoteDatasourceImp({required this.networkInfo, required this.client});

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
}
