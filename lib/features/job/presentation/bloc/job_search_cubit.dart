
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/job/domain/usercase/get_all_jobs_by_company.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/entities/job.dart';
import '../../domain/usercase/get_job.dart';
import '../../domain/usercase/search_jobs.dart';
import 'job_cubit.dart';



class JobSearchCubit extends Cubit<JobState> {
  final GetJobUserCase getJobUserCase;
  JobSearchCubit({
    required this.getJobUserCase}) : super(JobInitial());


  Future<void> searchJob(Map<String,dynamic>? value) async {
    emit(JobLoadingState());
    final failureOrSuccess = await getJobUserCase.callAll(
    value!['searchVal'],value['nationality']
    ,value['city'],value['category'],);
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

