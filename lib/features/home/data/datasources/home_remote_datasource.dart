
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/features/home/data/models/home_model.dart';
import 'package:hr_career_platform/features/job/data/models/job_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeUser();
  Future<List<JobModel>> getHomeCompany(String companyId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient supBase;

  HomeRemoteDataSourceImpl({ required this.supBase});
  @override
  Future<List<JobModel>> getHomeCompany(String companyId) async {
    try {
      final data = await supBase.from('jobs').select('''
    *,
    company (
      *
    )
  ''').eq('company_id', companyId).order('created_at').limit(10);

      final List<JobModel> jobList =
      data.map((json) => JobModel.fromJson(json)).toList();
      return jobList;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException();
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