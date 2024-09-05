import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/strings/failures.dart';
import 'package:hr_career_platform/features/general/domain/entities/general.dart';
import 'package:hr_career_platform/features/general/domain/usecases/fetch_general.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  final GetGeneralUseCase getGeneralUseCase;

  GeneralCubit({required this.getGeneralUseCase}) : super(GeneralInitial());

  Future<void> getGeneral() async {
    emit(const GeneralLoading());
    final failureOrSuccess = await getGeneralUseCase.call();
    emit(_mapFailureOrGeneralToState(failureOrSuccess));
  }

  GeneralState _mapFailureOrGeneralToState(Either<Failure, General> either) {
    return either.fold(
      (failure) => GeneralErrorState(msg: _mapFailureToMessage(failure)),
      (generals) {
        print(generals.companyMajor.toString());
        print(generals.cities.toString());
        return GeneralFetchedState(generals: generals);},
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
