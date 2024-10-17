import 'package:hr_career_platform/features/notification/domain/entities/notification.dart';

class NotificationModel extends NotificationApp {
  NotificationModel(
      {super.id,
      required super.createdAt,
      required super.body,
      super.userType,
      super.isArchived,
      required super.title});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          id: json["id"] ?? '',
          createdAt: json["created_at"] ?? '',
          body: json["body"] ?? '',
          userType: json["user_type"] ?? '',
          title: json["title"] ?? '',
          isArchived: json["is_archive"]);

  factory NotificationModel.formNotification(NotificationApp? notification) {
    return NotificationModel(
        id: notification!.id,
        createdAt: notification.createdAt,
        body: notification.body,
        title: notification.title,
        userType: notification.userType,
        isArchived: notification.isArchived);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "body": body,
        "user_type": userType,
        "title": title,
        "is_archive": isArchived
      };
}
