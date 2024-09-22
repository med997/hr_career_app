import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/strings/failures.dart';
import 'package:hr_career_platform/features/home/domain/entities/home.dart';
import 'package:hr_career_platform/features/home/domain/usecases/fetch_home.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeUserCase getHomeUserCase;

  HomeCubit({required this.getHomeUserCase}) : super(const HomeInitial());



  Future<void> getUserHome() async {
    emit(const HomeLoading());
    final failureOrSuccess = await getHomeUserCase.call();
    emit(_mapFailureOrHomeToState(failureOrSuccess));
  }

  Future<void> getCompanyHome(String companyId) async {
    emit(const HomeLoading());
    final failureOrSuccess = await getHomeUserCase.callCompanyHome(companyId);
    emit(_mapFailureOrHomeToState(failureOrSuccess));
  }

  HomeState _mapFailureOrHomeToState(Either<Failure, Home> either) {
    return either.fold(
          (failure) => HomeErrorState(msg: _mapFailureToMessage(failure)),
          (homes) => HomeFetchedState(
           homes: homes
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
