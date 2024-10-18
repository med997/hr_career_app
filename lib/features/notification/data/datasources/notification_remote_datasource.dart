import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDatasource{
  Future<List<NotificationModel>>  getNotificationByUuid(String uuid);
  Future<Unit> updateNotification(String id);
}
class NotificationRemoteDatasourceImp extends NotificationRemoteDatasource{
  final SupabaseClient client;

  NotificationRemoteDatasourceImp({required this.client});
  @override
  Future<List<NotificationModel>> getNotificationByUuid(String uuid) async {
    try {
      final data = await client.from('notifications').select('*').eq('user_id', uuid);
      print(data.toString());
      final List<NotificationModel> notificationList =
      data.map((json) => NotificationModel.fromJson(json)).toList();
      return notificationList;
    } on PostgrestException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: error.message);
    }  catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw ServerException(message: error.toString());
    }
  }

  @override
  Future<Unit> updateNotification(String id) async {
    try {
      Map<String,dynamic> param={'is_archive':true};
      final data = await client
          .from('notifications')
          .update(param)
          .eq('id',id).select().single();
      final NotificationModel ntf = NotificationModel.fromJson(data);
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