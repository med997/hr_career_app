/*
final AuthResponse res = await supabase.auth.signUp(
email: 'example@email.com',
password: 'example-password',
);
final Session? session = res.session;
final User? user = res.user;*/

import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/core/error/exceptions.dart';
import 'package:hr_career_platform/features/auth/data/models/auth_model.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/profile/data/models/profile_model.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> signup(Auth authModel);

  Future<AuthModel> login(AuthModel authModel);

}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final SupabaseClient supBase;

  AuthRemoteDatasourceImpl({required this.supBase});

  @override
  Future<AuthModel> login(AuthModel authModel) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<AuthModel> signup(Auth authModel) async {
    try {
      ProfileModel model = ProfileModel.fromProfile(authModel.profile);
      final data = await supBase.auth.signUp(
        email: authModel.email,
        password: authModel.password,
        data: model.toJson(),
      );
      final Session? session = data.session;
      final User? user = data.user;
      print(user.toString());
      final AuthModel authModelData = AuthModel(
          email: user!.email ?? '',
          password: '',
          userAuth: user,
          profile: ProfileModel.fromJson(user!.appMetadata));
      return authModelData;
    } on AuthException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException();
    }catch(e)  {
      if (kDebugMode) {
        print(e);
      }
      throw ServerException();
    }
  }
}
