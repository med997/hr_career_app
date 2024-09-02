/*
final AuthResponse res = await supabase.auth.signUp(
email: 'example@email.com',
password: 'example-password',
);
final Session? session = res.session;
final User? user = res.user;*/

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
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

  Future<AuthModel> login(Auth authModel);

  Future<AuthModel?> getCurrentUserData();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final SupabaseClient supBase;

  AuthRemoteDatasourceImpl({required this.supBase});

  @override
  Session? get currentUserSession => supBase.auth.currentSession;

  @override
  Future<AuthModel> login(Auth authModel) async {
    try {
      final AuthModel authModelData;
      final res = await supBase.auth.signInWithPassword(
        email: authModel.email,
        password: authModel.password,
      );

      final User? user = res.user;
      print(user.toString());
      UsrType usrType = user!.userMetadata!['userType'];
      if (usrType == UsrType.company) {
        authModelData = AuthModel(
            userType: usrType,
            email: user.email ?? '',
            password: '',
            userAuth: user,
            company: CompanyModel.fromJson(user.userMetadata??{}));
      } else {
        authModelData = AuthModel(
            userType: usrType,
            email: user.email ?? '',
            password: '',
            userAuth: user,
            profile: ProfileModel.fromJson(user.userMetadata??{}));
      }
      return authModelData;
    } on AuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: error.message);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException(message: 'Something Wrong');
    }
  }

  @override
  Future<AuthModel> signup(Auth authModel) async {
    try {
      final AuthResponse data;
      final AuthModel authModelData;
      final User user;
      if (authModel.userType == UsrType.user) {
        ProfileModel model = ProfileModel.fromProfile(authModel.profile);
        Map<String, String> userTypeMap = {'userType': UsrType.user.name};
        data = await supBase.auth.signUp(
          email: authModel.email,
          password: authModel.password,
          data: {...userTypeMap, ...model.toJson()},
        );
        user = data.user!;
        authModelData = AuthModel(
            userType: UsrType.user,
            email: user.email ?? '',
            password: '',
            userAuth: user,
            profile: ProfileModel.fromJson(user.userMetadata ?? {}));
      } else {
        Map<String, String> userTypeMap = {'userType': UsrType.company.name};
        CompanyModel model = CompanyModel.fromCompany(authModel.company);
        data = await supBase.auth.signUp(
          email: authModel.email,
          password: authModel.password,
          data: {...userTypeMap, ...model.toJson()},
        );
        user = data.user!;
        authModelData = AuthModel(
            userType:UsrType.company,
            email: user.email ?? '',
            password: '',
            userAuth: user,
            company: CompanyModel.fromJson(user.userMetadata ?? {}));
      }

      print(user.toString());

      return authModelData;
    } on AuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: error.message);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw const ServerException(message: 'Something Wrong');
    }
  }

  @override
  Future<AuthModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        print('getCurrentUserData');
        print(currentUserSession!.user.toString());
        User? user = currentUserSession!.user;
        AuthModel authModelData;
        UsrType usrType = user.userMetadata!['userType']=="user"?UsrType.user:UsrType.company;
        print('getCurrentUserData');
        print(usrType.toString());
        if (usrType == UsrType.company) {
           authModelData = AuthModel(
              userType: usrType,
              email: user.email ?? '',
              password: '',
              userAuth: user,
              company: CompanyModel.fromJson(user.userMetadata??{}));
        } else {
          authModelData = AuthModel(
              userType: usrType,
              email: user.email ?? '',
              password: '',
              userAuth: user,
              profile: ProfileModel.fromJson(user.userMetadata??{}));
        }
        return authModelData;

      }
      return null;
    } on AuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException(message: e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw ServerException(message: e.toString());
    }
  }
}
