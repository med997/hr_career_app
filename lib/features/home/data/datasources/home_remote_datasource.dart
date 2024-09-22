
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/features/home/data/models/home_model.dart';
import 'package:hr_career_platform/features/job/data/models/job_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeUser();
  Future<HomeModel> getHomeCompany(String companyId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient supBase;

  HomeRemoteDataSourceImpl({ required this.supBase});
  @override
  Future<HomeModel> getHomeCompany(String companyId) async {
    try {
      Map<String,dynamic> param={'cmp_id': companyId};
      final data = await supBase.rpc('company_home',params: param);
      print('getHomeCompany');
      print(data.toString());  print(companyId);
      final HomeModel homeList = HomeModel.fromJson(data);
      return homeList;
    } on PostgrestException catch (error) {

      if (kDebugMode) {
        print('PostgrestException ==> ${error.message}');
      }

      throw ServerException(message: error.message);
    }catch(e){
      if (kDebugMode) {
        print('anyException ==> ${e}');
      }

      throw ServerException(message: 'something wrong  !!!');

    }
  }

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
      if (kDebugMode) {
        print(e.toString());
      }

      throw ServerException(message: 'something wrong  !!!');

    }
  }
}