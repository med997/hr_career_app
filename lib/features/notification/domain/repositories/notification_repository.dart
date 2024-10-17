import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/notification/domain/entities/notification.dart';
import '../../../../core/error/failures.dart';

abstract class NotificationRepository{
  Future<Either<Failure, List<NotificationApp>>>  getNotificationByUuid(String uuid);
}