
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/notification/domain/entities/notification.dart';
import 'package:hr_career_platform/features/notification/domain/repositories/notification_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/notification_remote_datasource.dart';


typedef DeleteOrUpdateNtf = Future<Unit> Function();
class NotificationRepositoryImpl extends NotificationRepository{
  final NotificationRemoteDatasource notificationRemoteDatasource;
  final NetworkInfo networkInfo;

  NotificationRepositoryImpl({required this.notificationRemoteDatasource, required this.networkInfo});
  @override
  Future<Either<Failure, List<NotificationApp>>> getNotificationByUuid(String uuid) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNotification = await notificationRemoteDatasource.getNotificationByUuid(uuid);
        return Right(remoteNotification);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNotification(String id) async {
    return await _getMessage(() => notificationRemoteDatasource.updateNotification(id));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateNtf deleteOrUpdateNtf) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNtf =  await deleteOrUpdateNtf();
        return  Right(remoteNtf);
      }on ServerException catch (e) {
        return Left(ServerFailure(messageServer:e.message??''));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}