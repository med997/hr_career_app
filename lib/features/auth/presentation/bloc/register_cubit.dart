import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoading());
    // final failureOrSuccess = await addAuth;
    // emit(_mapFailureOrRegisterToState(failureOrSuccess));
  }

    RegisterState _mapFailureOrRegisterToState(Either<Failure, Unit> either) {
      return either.fold(
            (failure) => RegisterErrorState(msg: _mapFailureToMessage(failure)),
            (unit) => RegisterSuccess(
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
