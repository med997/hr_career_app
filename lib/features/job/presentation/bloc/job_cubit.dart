
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/job/domain/usercase/get_all_jobs_by_company.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/entities/job.dart';
import '../../domain/usercase/get_job.dart';
import '../../domain/usercase/search_jobs.dart';


part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final GetJobUserCase getJobUserCase;
  final SearchJobsUserCase searchJobsUserCase;
  final GetAllJobsByCompany getAllJobsByCompanyUserCase;
  JobCubit({required this.getAllJobsByCompanyUserCase, required this.getJobUserCase, required this.searchJobsUserCase}) : super(JobInitial());


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
  Future<void> searchJob({ int? companyId, required String category, String? nationalities}) async {
    emit(JobLoadingState());
    final failureOrSuccess = await searchJobsUserCase.call(companyId!, category, nationalities,);
    emit(_mapFailureOrJobsToState(failureOrSuccess));
  }

  Future<void> getAllJobsByCompany(String companyId) async {
    emit(JobLoadingState());
    final failureOrSuccess = await getAllJobsByCompanyUserCase.call(companyId);
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

