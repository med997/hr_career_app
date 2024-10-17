
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/notification/domain/entities/notification.dart';
import 'package:hr_career_platform/features/notification/domain/repositories/notification_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/notification_remote_datasource.dart';

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
}