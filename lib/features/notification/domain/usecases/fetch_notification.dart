
import 'package:dartz/dartz.dart';
import 'package:hr_career_platform/features/notification/domain/entities/notification.dart';
import 'package:hr_career_platform/features/notification/domain/repositories/notification_repository.dart';

import '../../../../core/error/failures.dart';

class FetchNotificationUseCase {
  final NotificationRepository notificationRepository;
  FetchNotificationUseCase(this.notificationRepository);

  Future<Either<Failure, List<NotificationApp>>> getNotificationByUuid(String uuid) async {
    return await notificationRepository.getNotificationByUuid(uuid);
  }
  Future<Either<Failure, Unit>> updateNotification(String id) async {
    return await notificationRepository.updateNotification(id);
  }
}