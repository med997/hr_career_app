part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {
  const NotificationInitial();
}
final class NotificationLoading extends NotificationState {
  const NotificationLoading();
}
final class NotificationFetchedState extends NotificationState {
  final List<NotificationApp> notification;
  NotificationFetchedState({required this.notification});
}
final class NotificationUpdateState extends NotificationState {

}

final class NotificationErrorState extends NotificationState{
  final String msg;
  const NotificationErrorState({required this.msg});
}
