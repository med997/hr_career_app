import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/features/company/data/models/company_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';

abstract class CompanyRemoteDatasource {
  Future<CompanyModel> getCompany();
  Future<CompanyModel> getCompanyByUuid(String uuid);
  Future<Unit> updateCompany(CompanyModel companyModel);
}

class CompanyRemoteDatasourceImp extends CompanyRemoteDatasource{
  final SupabaseClient client;

  CompanyRemoteDatasourceImp({required this.client});
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
  Future<CompanyModel> getCompanyByUuid(String uuid) async {
    try {
      final data = await client.from('company').select('*').eq('id', uuid).limit(1);

      print(data[0].toString());
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
  Future<Unit> updateCompany(CompanyModel companyModel) async {
    try {
      final data = await client
          .from('company')
          .update(companyModel.toJson())
          .eq('id', companyModel.id.toString());
      return Future.value(unit);
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