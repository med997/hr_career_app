import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/domain/usercase/update_job.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/usercase/add_job.dart';

part 'curd_job_state.dart';

class CurdJobCubit extends Cubit<CurdJobState> {
  final AddJobUserCase addJobUserCase;
  final UpdateJob updateJobUseCase;
  CurdJobCubit({required this.addJobUserCase, required this.updateJobUseCase}) : super(CurdJobInitial());


  Future<void> updateJob(Map<String,dynamic>? value) async {
    emit(LoadingCurdJobState());

    Job job = Job(
        jobTitle: value!['jobTitle'],
        gender: value['gender'],
        office: value['office'],
        otherApplyLinks: value['otherApplyLinks'],
        address: value['address'],
        timeParts: value['timeParts'],
        city: value['city'],
        qualifications: value['qualifications'],
        category: value['category'],
        deadlineDate: value['deadlineDate'],
        jobDesc: value['jobDesc'],
        jobRequirements: value['jobRequirements']);

    final failureOrSuccess = await updateJobUseCase.call(job);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }
  Future<void> insertJob(Map<String,dynamic>? value) async {
    emit(LoadingCurdJobState());
    Job job = Job(
        jobTitle: value!['jobTitle'],
        gender: value['gender'],
        office: value['office'],
        otherApplyLinks: value['otherApplyLinks'],
        address: value['address'],
        timeParts: value['timeParts'],
        city: value['city']??'',
        category: value['category']??'',
        nationalities: value['nationalities'],
        qualifications: value['qualifications'],
        status: 'draft',
        deadlineDate:DateTime.now(),
        jobDesc: value['jobDesc'],
        companyId: '04363fab-42e2-4b7e-9d6c-10bfb68f138b',
        jobRequirements: value['jobRequirements']);
    final failureOrSuccess = await addJobUserCase.call(job);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'insertDone'));
  }

  CurdJobState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
          (failure) => ErrorCurdJobState(
        message: _mapFailureToMessage(failure),
      ),
          (_) => MessageCurdJobState(message: message),
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
