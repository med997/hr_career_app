import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

import '../../../../core/strings/failures.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/fetch_profile.dart';

part 'appliance_state.dart';

class ApplianceCubit extends Cubit<ApplianceState> {
  final FetchProfileUserCase getProfileUserCase;
  ApplianceCubit({required this.getProfileUserCase}) : super(ApplianceInitial());

  Future<void> getAppliance(String jobId) async {
    emit( ApplianceLoading());
    final failureOrSuccess = await getProfileUserCase.getAppliance(jobId);
    emit(_mapFailureOrHomeToState(failureOrSuccess));
  }

  ApplianceState _mapFailureOrHomeToState(Either<Failure, List<Profile>> either) {
    return either.fold(
          (failure) => ApplianceErrorState(msg: _mapFailureToMessage(failure)),
          (profile) => ApplianceFetchedState(
            profile: profile
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
