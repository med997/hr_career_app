import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/notification/domain/entities/notification.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/usecases/fetch_notification.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final FetchNotificationUseCase notificationUseCase;
  NotificationCubit({required this.notificationUseCase}) : super(const NotificationInitial());

  Future<void> getNotificationByUuid(String uuid) async {
    emit(const NotificationLoading());
    final failureOrSuccess = await notificationUseCase.getNotificationByUuid(uuid);
    emit(_mapFailureOrHomeToState(failureOrSuccess));
  }

  NotificationState  _mapFailureOrHomeToState(Either<Failure, List<NotificationApp>> either) {
    return either.fold(
          (failure) => NotificationErrorState(msg: _mapFailureToMessage(failure)),
          (notification) => NotificationFetchedState(
              notification: notification
      ),
    );
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (EmptyCacheFailure):
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Something want wrong .. try again";
    }
  }
}
