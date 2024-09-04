import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/payment/data/models/package_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PackageModel>> getPackages(PkgType type);
}

class PaymentsRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final SupabaseClient supBase;

  PaymentsRemoteDataSourceImpl({ required this.supBase});

  @override
  Future<List<PackageModel>> getPackages(PkgType type) async {
    try {
      final data = await supBase.from('package').select('*').eq('type', type.name);
      print(data.toString());
      final List<PackageModel> pkgList =  data.map((json) => PackageModel.fromJson(json)).toList();
      return pkgList;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error.message);
      }

      throw ServerException(message: error.message);
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      throw const ServerException(message: 'something wrong  !!!');

    }
  }
}