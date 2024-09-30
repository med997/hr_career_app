import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/general/data/models/General_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/enums.dart';
import '../../../company/data/models/company_model.dart';
import '../../../profile/data/models/profile_model.dart';


abstract class GeneralLocalDataSource {
  Future<GeneralModel> getCachedGenerals();
  Future<Unit> cacheGenerals(GeneralModel GeneralModels);
}

const CACHED_GENERALS = "CACHED_GENERAL";

class GeneralLocalDataSourceImpl implements GeneralLocalDataSource {
  final SharedPreferences sharedPreferences;

  GeneralLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheGenerals(GeneralModel generalModels) async {
    sharedPreferences.setString(CACHED_GENERALS, json.encode(generalModels.toJson()));
    return Future.value(unit);
  }

  @override
  Future<GeneralModel> getCachedGenerals() {
    final jsonString = sharedPreferences.getString(CACHED_GENERALS);
    if (jsonString != null) {
      final decodeJsonData = json.decode(jsonString);
      print(decodeJsonData);
      GeneralModel generalModelData = GeneralModel.fromJson(decodeJsonData);

      return  Future.value(generalModelData);
    } else {
      throw EmptyCacheException();
    }
  }
}