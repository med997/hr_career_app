import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/util/const_val.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/enums.dart';
import '../../../company/data/models/company_model.dart';
import '../../../profile/data/models/profile_model.dart';
import '../models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<AuthModel> getCachedAuths();
  Future<Unit> clearCachedAuths();
  Future<Unit> cacheAuths(AuthModel authModels);
}

const CACHED_POSTS = "CACHED_AUTH";

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheAuths(AuthModel authModels) async {
    // AuthModel authModelsToJson = authModels
        // .map<Map<String, dynamic>>((authModel) => authModel.toJson())
        // .toList();
    try {
      sharedPreferences.setString(
          CACHED_POSTS, jsonEncode(authModels.toJson()));
      return Future.value(unit);
    }catch (e){
      print(e.toString());
      throw EmptyCacheException();
    }
  }

  @override
  Future<AuthModel> getCachedAuths() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      final decodeJsonData = json.decode(jsonString);
      print(decodeJsonData);
      AuthModel authModelData;
      UsrType usrType =decodeJsonData['email']==GustEmail?UsrType.user:
      decodeJsonData['userAuth']['user_metadata']['userType'] == "user" ? UsrType
          .user : UsrType.company;
      print('getCurrentUserData');
      print(usrType.toString());
      if (usrType == UsrType.company) {
        authModelData = AuthModel(
            userType: usrType,
            email: decodeJsonData['email'] ?? '',
            password: '',
            userAuth: User.fromJson(decodeJsonData['userAuth']),
            company: CompanyModel.fromJson(decodeJsonData['userAuth']['userMetadata'] ?? {}));
      } else {
        print('identity_data');
        print(decodeJsonData['userAuth']['user_metadata'].toString());
        authModelData = AuthModel(
            userType: usrType,
            email: decodeJsonData['email'] ?? '',
            password: '',
            userAuth: User.fromJson(decodeJsonData['userAuth']),
            profile: ProfileModel.fromJson(decodeJsonData['userAuth']['user_metadata']));
      }
      return  Future.value(authModelData);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> clearCachedAuths() {
    sharedPreferences.clear();
    return Future.value(unit);

  }
}