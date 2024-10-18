import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../models/tender_model.dart';

abstract class TenderRemoteDataSource {
  Future<TenderModel> addTender(TenderModel tenderModel);
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
}
