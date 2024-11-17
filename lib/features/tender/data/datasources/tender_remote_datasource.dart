import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../models/tender_model.dart';

abstract class TenderRemoteDataSource {
  Future<TenderModel> addTender(TenderModel tenderModel);
  Future<TenderModel> updateTender(TenderModel tenderModel);
  Future<List<TenderModel>> getAllActiveTendersByCompany(String companyId);


}

class TenderRemoteDataSourceImpl implements TenderRemoteDataSource {
  final SupabaseClient supBase;

  TenderRemoteDataSourceImpl({required this.supBase});


  @override
  Future<TenderModel> addTender(TenderModel tenderModel) async {
    try {
      final data =
          await supBase.from('tender').insert(tenderModel.toJson()).select();
      print(data.toString());
      final TenderModel tender = TenderModel.fromJson(data.first);
      return tender;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: '${error.message} - ${error.code}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TenderModel> updateTender(TenderModel tenderModel) async {
    try {
      final data = await supBase
          .from('tender')
          .update(tenderModel.toJson())
          .eq('id', tenderModel.id.toString()).select().single();
      final TenderModel tender =TenderModel.fromJson(data);
      return tender;
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
  Future<List<TenderModel>> getAllActiveTendersByCompany(String companyId) async{
    try {
      final data = await supBase.from('tender').select('''
    *,
    company (
      *
    )
  ''').eq("company_id", companyId).eq('status', 'active').order('created_at').limit(100);

      final List<TenderModel> tenderList =
      data.map((json) => TenderModel.fromJson(json)).toList();
      return tenderList;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException();
    }
  }
}
