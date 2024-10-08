import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileModel> getUser();
  Future<ProfileModel> getUserByUuid(String uuid);
  Future<ProfileModel> updateProfileFcmToken(ProfileModel profileModel);
  Future<ProfileModel> updateProfile(ProfileModel profileModel);
  Future<List<ProfileModel>> getAppliance(String profileId);
  Future<ProfileModel> uploadImageProfile(File file,String id);
}

class ProfileRemoteDatasourceImp extends ProfileRemoteDatasource {
  final SupabaseClient client;

  @override
  Future<ProfileModel> updateProfileFcmToken(ProfileModel profileModel) async {
    try {
      final data = await client
          .from('profiles')
          .update({ 'fcm_token': profileModel.fcmToken})
          .eq('id', profileModel.id.toString()).select();
      return ProfileModel.fromJson(data.first);
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
  ProfileRemoteDatasourceImp({ required this.client});

  @override
  Future<ProfileModel> getUser() async {
    try {
      final data = await client.from('profiles').select();

      if (data.isNotEmpty) {
        return ProfileModel.fromJson(data[0]);
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
  Future<ProfileModel> getUserByUuid(String uuid)async {

    try {
      final data = await client.from('profiles').select('*').eq('id', uuid).limit(1);

      print(data[0].toString());
      if (data.isNotEmpty) {
        return ProfileModel.fromJson(data[0]);
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
  Future<List<ProfileModel>> getAppliance(String profileId) async {
    try {
      Map<String,dynamic> param={'job_id':int.parse(profileId) };
      final data = await client.rpc('get_appliance',params: param).select();
   //   final data = await client.from('profiles').select();
      print('getAppliance');
      print(data.toString());
      print(profileId);
      final List<ProfileModel> profileList =
      data.map((json) => ProfileModel.fromJson(json)).toList();
      return profileList;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print('PostgrestException ==> ${error.message}');
      }
      throw ServerException(message: error.message);
    }catch(e) {
      if (kDebugMode) {
        print('anyException ==> ${e}');
      }
      throw ServerException(message: 'something wrong  !!!');
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profileModel) async{
    try {
      final data = await client
          .from('profiles')
          .update(profileModel.toJson())
          .eq('id', profileModel.id.toString()).select().single();
      final ProfileModel profileUpdate = ProfileModel.fromJson(data);
      return profileUpdate;
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
  Future<ProfileModel> uploadImageProfile(File file,String id) async{
    try {
      final avatarFile =file;
      final String uploadedFile= await client.storage.from('avatars').upload(
        'public/${id}-${DateTime.now().millisecondsSinceEpoch}${p.extension(file.path)}',
        avatarFile,
      );

        final data = await client
            .from('profiles')
            .update({'avatar_url':uploadedFile.isNotEmpty?uploadedFile:''})
            .eq('id', id).select().single();
        final ProfileModel profileUpdate = ProfileModel.fromJson(data);
        return profileUpdate;


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
}
