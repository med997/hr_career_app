import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/features/company/data/models/company_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p;
import '../../../../core/error/exceptions.dart';

abstract class CompanyRemoteDatasource {
  Future<CompanyModel> getCompany();
  Future<CompanyModel> getCompanyByUuid(String uuid);
  Future<CompanyModel> uploadImageCompany(String path,String id);
  Future<CompanyModel> updateCompany(CompanyModel companyModel);
  Future<CompanyModel> updateCompanyFcmToken(String uuid , String fcmToken);
}




class CompanyRemoteDatasourceImp extends CompanyRemoteDatasource{
  final SupabaseClient client;

  CompanyRemoteDatasourceImp({required this.client});
  @override
  Future<CompanyModel> uploadImageCompany(String path,String id) async{
    try {
      final File file = File(path);
      final avatarFile =file;
      final String uploadedFile= await client.storage.from('company_logo').upload(
        'public/${id}-${DateTime.now().millisecondsSinceEpoch}${p.extension(file.path)}',
        avatarFile,
      );

      final data = await client
          .from('company')
          .update({'company_logo':uploadedFile.isNotEmpty?uploadedFile:''})
          .eq('id', id).select().single();
      final CompanyModel companyUpdate = CompanyModel.fromJson(data);
      return companyUpdate;


    } on StorageException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: '${error.message} - ${error.message}');
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
  Future<CompanyModel> getCompany() async {
    try {
      final data = await client.from('company').select();
      if (data.isNotEmpty) {
        return CompanyModel.fromJson(data[0]);
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
  Future<CompanyModel> updateCompanyFcmToken(String uuid , String fcmToken) async {
    try {
      final data = await client
          .from('company')
          .update({'fcm_token':fcmToken})
          .eq('id', uuid).select().single();
      final CompanyModel companyUpdate = CompanyModel.fromJson(data);
      return companyUpdate;
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
  Future<CompanyModel> getCompanyByUuid(String uuid) async {
    try {
      final data = await client.from('company').select('*').eq('id', uuid).limit(1);

      if (data.isNotEmpty) {
        return CompanyModel.fromJson(data[0]);
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

  @override
  Future<CompanyModel> updateCompany(CompanyModel companyModel) async {
    try {
      final data = await client
          .from('company')
          .update(companyModel.toJson())
          .eq('id', companyModel.id.toString()).select().single();
      final CompanyModel companyUpdate = CompanyModel.fromJson(data);
      return companyUpdate;
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
}