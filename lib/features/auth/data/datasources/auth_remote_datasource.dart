/*
final AuthResponse res = await supabase.auth.signUp(
email: 'example@email.com',
password: 'example-password',
);
final Session? session = res.session;
final User? user = res.user;*/

import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/auth/data/models/auth_model.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/company/data/models/company_model.dart';
import 'package:hr_career_platform/features/profile/data/models/profile_model.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDatasource {
  Session? get currentUserSession;
  Future<AuthModel> signup(Auth authModel);

  Future<AuthModel> login(AuthModel authModel);


  Future<AuthModel?> getCurrentUserData();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final SupabaseClient supBase;

  AuthRemoteDatasourceImpl({required this.supBase});

  @override
  Session? get currentUserSession => supBase.auth.currentSession;

  @override
  Future<AuthModel> login(AuthModel authModel) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<AuthModel> signup(Auth authModel) async {
    try {
      final data;

      if(authModel.userType==UsrType.user){
        ProfileModel model = ProfileModel.fromProfile(authModel.profile);
        Map<String, String> userTypeMap= {'userType': UsrType.user.name};

        data = await supBase.auth.signUp(
          email: authModel.email,
          password: authModel.password,
          data: {...userTypeMap,...model.toJson()},
        );
      }else{
        Map<String, String> userTypeMap= {'userType': UsrType.company.name};
    CompanyModel model = CompanyModel.fromCompany(authModel.company);
        data = await supBase.auth.signUp(
          email: authModel.email,
          password: authModel.password,
          data: {...userTypeMap,...model.toJson()},
        );
      }
      final User? user = data.user;
      print(user.toString());
      final AuthModel authModelData = AuthModel(
        userType: user!.appMetadata['userType'],
          email: user.email ?? '',
          password: '',
          userAuth: user,
          profile: ProfileModel.fromJson(user.appMetadata));
      return authModelData;
    } on AuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message:  error.message);
    }catch(e)  {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException(message: 'Something Wrong');
    }
  }


  @override
  Future<AuthModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supBase
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return AuthModel.fromJson(userData.first);
      }
      return null;
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
