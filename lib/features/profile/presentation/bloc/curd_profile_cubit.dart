import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/domain/usecases/update_profile.dart';

import '../../../../core/strings/failures.dart';

part 'curd_profile_state.dart';

class CurdProfileCubit extends Cubit<CurdProfileState> {
  final UpdateProfileUseCase updateProfileUserCase;
  CurdProfileCubit({required this.updateProfileUserCase}) : super(CurdProfileInitial());

  Future<void> updateProfile(Profile profile) async {
    if (profile.id == null) {
      emit(const ErrorCurdProfileState(message: "ID cannot be null"));
      return;
    }
    emit(LoadingCurdProfileState());
    final failureOrSuccess = await updateProfileUserCase.updateFcmToken(profile);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }
  CurdProfileState _eitherDoneMessageOrErrorState(
      Either<Failure, Profile> either, String message) {
    return either.fold(
          (failure) => ErrorCurdProfileState(
        message: _mapFailureToMessage(failure),
      ),
          (_) => MessageCurdProfileState(message: message),
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
