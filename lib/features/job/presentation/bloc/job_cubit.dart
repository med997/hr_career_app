import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/job/domain/usercase/search_jobs.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/entities/job.dart';
import '../../domain/usercase/get_job.dart';


part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final GetJobUserCase getJobUserCase;
  final SearchJobsUserCase searchJobsUserCase;
  JobCubit({required this.getJobUserCase, required this.searchJobsUserCase}) : super(JobInitial());


  Future<void> getAllJobs() async {
    emit(JobLoadingState());
    final failureOrSuccess = await getJobUserCase.callAll();
    emit(_mapFailureOrJobsToState(failureOrSuccess));
  }

  JobState _mapFailureOrJobsToState(Either<Failure, List<Job>> either) {
    return either.fold(
          (failure) => JobErrorState(msg: _mapFailureToMessage(failure)),
          (jobs) => JobFetchedState(
              jobs: jobs
          ),
    );
  }
  Future<void> searchJob() async {
    emit(JobLoadingState());
    final failureOrSuccess = await searchJobsUserCase.repository.call();
    emit(_mapFailureOrJobsToState(failureOrSuccess));
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

