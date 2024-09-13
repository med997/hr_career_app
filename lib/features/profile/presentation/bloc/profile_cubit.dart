import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/strings/failures.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/usecases/fetch_profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  final FetchProfileUserCase fetchProfileUserCase;
  ProfileCubit({required this.fetchProfileUserCase}) : super(const ProfileInitial());

  Future<void> getUserByUuid(String uuid) async {
    emit(const ProfileLoading());
    final failureOrSuccess = await fetchProfileUserCase.getUserByUuid(uuid);
    emit(_mapFailureOrHomeToState(failureOrSuccess));
  }

  ProfileState _mapFailureOrHomeToState(Either<Failure, Profile> either) {
    return either.fold(
          (failure) => ProfileErrorState(msg: _mapFailureToMessage(failure)),
          (profile) => ProfileFetchedState(
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
