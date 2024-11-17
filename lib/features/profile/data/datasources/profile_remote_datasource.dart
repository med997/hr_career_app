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
  Future<ProfileModel> updateProfileFcmToken(String uuid ,  List<String>? fcmToken);
  Future<ProfileModel> updateProfile(Map<String, dynamic>? value,String id);
  Future<ProfileModel> updateProfileExp(Map<String, dynamic>? value,String id);
  Future<ProfileModel> updateProfileEdc(Map<String, dynamic>? value,String id);
  Future<List<ProfileModel>> getAppliance(String profileId);
  Future<ProfileModel> uploadImageProfile(dynamic file,String id);
  Future<ProfileModel> uploadPdf(dynamic pdf,String id);
}

class ProfileRemoteDatasourceImp extends ProfileRemoteDatasource {
  final SupabaseClient client;

  @override
  Future<ProfileModel> updateProfileFcmToken(String uuid ,  List<String>? fcmToken) async {
    try {
      final data = await client
          .from('profiles')
          .update({ 'fcm_token': fcmToken})
          .eq('id', uuid)

          .select();
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
  Future<ProfileModel> updateProfile(Map<String, dynamic>? value,String id) async{
    try {
      final data = await client
          .from('profiles')
          .update(value!)
          .eq('id', id.toString()).select().single();
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
  Future<ProfileModel> updateProfileExp(Map<String, dynamic>? value,String id) async{
    try {
      final data = await client
          .from('profiles')
          .update(value!)
          .eq('id',id).select().single();
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
  Future<ProfileModel> uploadImageProfile(dynamic file,String id) async{
    try {
      final avatarFile;
      final String uploadedFile;
      if(kIsWeb){

        avatarFile= file;
        uploadedFile = await client.storage.from('avatars').uploadBinary(
          'public/$id-${DateTime.now().millisecondsSinceEpoch}.png',
          avatarFile,
        );

      }else {
        avatarFile = File(file);
        uploadedFile = await client.storage.from('avatars').upload(
          'public/${id}-${DateTime
              .now()
              .millisecondsSinceEpoch}${p.extension(avatarFile.path)}',
          avatarFile,
        );
      }



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

  @override
  Future<ProfileModel> updateProfileEdc(Map<String, dynamic>? value, String id) async {
    try {
      final data = await client
          .from('profiles')
          .update(value!)
          .eq('id',id).select().single();
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
  Future<ProfileModel> uploadPdf(pdf, String id) async {
    try  {
      final pdfFile;
      final String uploadedPdfFile;
      if(kIsWeb){
        pdfFile= pdf;
        uploadedPdfFile = await client.storage.from('resume').uploadBinary(
          'public/$id-${DateTime.now().millisecondsSinceEpoch}.pdf',
          pdfFile,
        );

      }else {
        pdfFile = File(pdf);
        uploadedPdfFile = await client.storage.from('resume').upload(
          'public/${id}-${DateTime
              .now()
              .millisecondsSinceEpoch}${p.extension(pdfFile.path)}',
          pdfFile,
        );
      }
      final data = await client
          .from('profiles')
          .update({'resume_url':uploadedPdfFile.isNotEmpty?uploadedPdfFile:''})
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
