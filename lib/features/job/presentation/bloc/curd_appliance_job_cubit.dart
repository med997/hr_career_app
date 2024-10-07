import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/usercase/add_appliance.dart';

part 'curd_appliance_job_state.dart';

class CurdApplianceJobCubit extends Cubit<CurdApplianceJobState> {
  final AddApplianceJobUseCase addApplianceJobUseCase;
  CurdApplianceJobCubit({required this.addApplianceJobUseCase}) : super(CurdApplianceJobInitial());

  Future<void> addApplianceJob(int jobId,String profileId) async{
    emit(LoadingCurdApplianceJobState());
    final failureOrSuccess = await addApplianceJobUseCase.call(jobId,profileId);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'insertDone'));
  }

  CurdApplianceJobState _eitherDoneMessageOrErrorState(
      Either<Failure, int> either, String message) {
    return either.fold(
          (failure) => ErrorCurdApplianceJobState(
        message: _mapFailureToMessage(failure),
      ),
          (applianceId) => MessageCurdApplianceJobState(message: message, applianceId: applianceId),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}
