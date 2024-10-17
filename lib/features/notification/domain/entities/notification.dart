import 'package:equatable/equatable.dart';

class NotificationApp extends Equatable {
  final String? id;
  final String createdAt;
  final String body;
  final int? userType;
  final String title;

  NotificationApp(
      {this.id,
        required this.createdAt,
        required this.body,
        this.userType,
        required this.title});

  @override
  List<Object?> get props => [];
}
