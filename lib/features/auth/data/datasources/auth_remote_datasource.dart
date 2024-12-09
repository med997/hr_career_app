import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/core/util/const_val.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/auth/data/models/auth_model.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/company/data/models/company_model.dart';
import 'package:hr_career_platform/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/strings/failures.dart';

abstract class AuthRemoteDatasource {
  Session? get currentUserSession;

  Future<AuthModel> signup(Auth authModel);

  Future<AuthModel> login(Auth authModel, String? fcmToken);
  Future<Unit> signupWithOtp(String token,String email);

  Future<Unit> signOut(UsrType usrType, String id, String fcmToken);
  Future<Unit> resendOtp(String email);
  Future<AuthModel> loginAsGust();
  Future<AuthModel> getCurrentUserData();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final SupabaseClient supBase;

  AuthRemoteDatasourceImpl({required this.supBase});

  @override
  Session? get currentUserSession => supBase.auth.currentSession;

  @override
  Future<AuthModel> login(Auth authModel, String? fcmToken) async {
    try {
      final AuthModel authModelData;
      final res = await supBase.auth.signInWithPassword(
        email: authModel.email.trim(),
        password: authModel.password,
      );
      final User? user = res.user;
      print(user.toString());
      UsrType usrType = user!.userMetadata!['userType'] == "user"
          ? UsrType.user
          : UsrType.company;

      Map<String, dynamic> param = {
        'p_profile_id': user.id,
        "p_new_token": fcmToken
      };
      if (usrType == UsrType.company) {
        final data = await supBase
            .rpc('update_fcm_token_company', params: param)
            .select()
            .single();
        authModelData = AuthModel(
            userType: usrType,
            email: user.email ?? '',
            password: '',
            fcmToken: [fcmToken ?? ''],
            userAuth: user,
            company: CompanyModel.fromJson(data));
      } else {
        final data = await supBase
            .rpc('update_fcm_token_profile', params: param)
            .select()
            .single();

        authModelData = AuthModel(
            userType: usrType,
            email: user.email ?? '',
            password: '',
            fcmToken: [fcmToken ?? ''],
            userAuth: user,
            profile: ProfileModel.fromJson(data));
      }
      return authModelData;
    } on AuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: '${error.message} - ${error.statusCode}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw const ServerException(message: 'Something Wrong');
    }
  }

  @override
  Future<AuthModel> loginAsGust() async {
    try {
      final AuthModel authModelData;
      final res = await supBase.auth.signInAnonymously();
      final User? user = res.user;
      print(user.toString());
        authModelData = AuthModel(
            userType: UsrType.user,
            email: GustEmail,
            password: '',
            fcmToken: [''],
            userAuth: user,
            profile:null);

      return authModelData;
    } on AuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: '${error.message} - ${error.statusCode}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw const ServerException(message: 'Something Wrong');
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
        print('====> ${model.toJson()}');
        Map<String, String> userTypeMap = {'userType': UsrType.user.name};
        data = await supBase.auth.signUp(
          email: authModel.email.trim(),
          password: authModel.password,
          data: {...userTypeMap, ...model.toJson()},
        );
        user = data.user!;
        authModelData = AuthModel(
            userType: UsrType.user,
            email: user.email ?? '',
            fcmToken: model.fcmToken,
            password: '',
            userAuth: user,
            profile: ProfileModel.fromJson(user.userMetadata ?? {}));
      } else {
        Map<String, dynamic> userTypeMap = {'userType': UsrType.company.name};

        CompanyModel model = CompanyModel.fromCompany(authModel.company);
        print(model.toJson());

        data = await supBase.auth.signUp(
          email: authModel.email.trim(),
          password: authModel.password,
          data: {...userTypeMap, ...model.toJson()},
        );
        user = data.user!;
        print(model.toJson());
        print(CompanyModel.fromJson(user.userMetadata ?? {}));
        authModelData = AuthModel(
            userType: UsrType.company,
            email: user.email ?? '',
            fcmToken: model.fcmToken,
            password: '',
            userAuth: user,
            company: CompanyModel.fromJson(user.userMetadata ?? {}));
        print(authModel.company!.phone);
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
  Future<Unit> signupWithOtp(String token,String email) async {
    try {
      await supBase.auth.verifyOTP(
    type: OtpType.signup,
    email: email,
    token: token
    );
    return Future.value(unit);
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
  Future<Unit> resendOtp(String email) async {
    try {
       await supBase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
    return Future.value(unit);
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
  Future<AuthModel> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        print('getCurrentUserData');
        print(currentUserSession!.user.toString());
        User? user = currentUserSession!.user;

        AuthModel authModelData;
        UsrType usrType = user.isAnonymous?UsrType.user:
        user.userMetadata!['userType'] == "user"
            ? UsrType.user
            : UsrType.company;
        List<String>? fcmToken = user.userMetadata!['fcm_token'];
        print('getCurrentUserData');
        print(fcmToken![0].toString());
        if (usrType == UsrType.company) {
          authModelData = AuthModel(
              userType: usrType,
              email: user.email ?? '',
              password: '',
              userAuth: user,
              company: CompanyModel.fromJson(user.userMetadata ?? {}));
        } else {
          authModelData = AuthModel(
              userType: usrType,
              email: user.email ?? '',
              fcmToken: fcmToken,
              password: '',
              userAuth: user,
              profile: ProfileModel.fromJson(user.userMetadata ?? {}));
        }
        return authModelData;
      } else {
        throw const AuthException(AUTH_FAILURE_MESSAGE);
      }
    } on AuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw AuthException(e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Unit> signOut(UsrType usrType, String id, String fcmToken) async {
    try {
      Map<String, dynamic> param = {
        'p_profile_id': id,
        "p_token": fcmToken
      };
      if (usrType == UsrType.user){
       await supBase.rpc('delete_fcm_token_profile', params: param).select().single();
      }else{
        await supBase.rpc('delete_fcm_token_company', params: param).select().single();
      }

        await supBase.auth.signOut();
      return Future.value(unit);
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
}
