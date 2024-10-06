
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/features/job/data/models/job_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class JobRemoteDataSource {
  Future<List<JobModel>> getAllJobs();

  Future<List<JobModel>> getLastJobs();

  Future<JobModel> updateJob(JobModel jobModel);

  Future<JobModel> addJob(JobModel jobModel);

  Future<List<JobModel>> getSearchJobs( int companyId, String category,String nationalities);



}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final SupabaseClient supBase;

  JobRemoteDataSourceImpl({required this.supBase});

  @override
  Future<List<JobModel>> getAllJobs() async {
    try {
      final data = await supBase.from('jobs').select('''
    *,
    company (
      *
    )
  ''').order('created_at').limit(100);

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
  Future<JobModel> addJob(JobModel jobModel) async{
    try {
      final data = await supBase
          .from('jobs')
          .insert(jobModel.toJson()).select();
      print(data.toString());
      final JobModel job =JobModel.fromJson(data.first);
      return job;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: '${error.message} - ${error.code}');
    }  catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<JobModel>> getLastJobs() async {
    try {
      final data = await supBase
          .from('jobs')
          .select('id, title')
          .order('id', ascending: false)
          .limit(10);
      final List<JobModel> jobList = jobFromJson(data.toString());
      return jobList;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException();
    }
  }

  @override
  Future<JobModel> updateJob(JobModel jobModel) async {
    try {
      final data = await supBase
          .from('jobs')
          .update(jobModel.toJson())
          .eq('id', jobModel.id.toString()).select().single();
      final JobModel job =JobModel.fromJson(data);
      return job;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: '${error.message} - ${error.code}');
    }  catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException(message: e.toString());
    }

  }

  @override
  Future<List<JobModel>> getSearchJobs(int companyId, String category, String? nationalities) async {
    try {
      final res = await supBase
          .from('jobs')
          .select('*, company(*)')
          .eq('company.id', companyId)
          .eq('category', category)
          .eq('nationalities', nationalities!);

      return res.map((json) => JobModel.fromJson(json)).toList();
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error); // Contains http status code
      }
      throw ServerException();
    }
  }
}
