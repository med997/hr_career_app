import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<List<AuthModel>> getCachedAuths();
  Future<Unit> cacheAuths(List<AuthModel> postModels);
}

const CACHED_POSTS = "CACHED_AUTH";

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheAuths(List<AuthModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<AuthModel>> getCachedAuths() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<AuthModel> jsonToAuthModels = decodeJsonData
          .map<AuthModel>((jsonAuthModel) => AuthModel.fromJson(jsonAuthModel))
          .toList();
      return Future.value(jsonToAuthModels);
    } else {
      throw EmptyCacheException();
    }
  }
}