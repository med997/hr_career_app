import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/General_model.dart';

abstract class GeneralRemoteDataSource {
  Future<GeneralModel> getGeneral();
}

class GeneralRemoteDataSourceImpl implements GeneralRemoteDataSource {
  final SupabaseClient supBase;

  GeneralRemoteDataSourceImpl({ required this.supBase});

  @override
  Future<GeneralModel> getGeneral() async {
    try {
      final data = await supBase.rpc('get_types');

      final GeneralModel generalList = GeneralModel.fromJson(data);
      return generalList;
    } on PostgrestException catch (error) {

      if (kDebugMode) {
        print(error.message);
      }

      throw ServerException(message: error.message);
    }catch(e){
      throw const ServerException(message: 'something wrong  !!!');

    }
  }
}