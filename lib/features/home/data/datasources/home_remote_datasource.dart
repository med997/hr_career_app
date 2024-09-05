
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/features/home/data/models/home_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeUser();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient supBase;

  HomeRemoteDataSourceImpl({ required this.supBase});

  @override
  Future<HomeModel> getHomeUser() async {
    try {
      final data = await supBase.rpc('user_home');

      final HomeModel homeList = HomeModel.fromJson(data);
      return homeList;
    } on PostgrestException catch (error) {

        if (kDebugMode) {
          print(error.message);
        }

        throw ServerException(message: error.message);
    }catch(e){
      throw ServerException(message: 'something wrong  !!!');

    }
  }
}