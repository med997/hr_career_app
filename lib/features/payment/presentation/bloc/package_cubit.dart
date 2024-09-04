import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/core/error/failures.dart';
import 'package:hr_career_platform/core/strings/failures.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';
import 'package:hr_career_platform/features/payment/domain/usecases/get_package.dart';


part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  final GetPackageUseCase getPackageUseCase;
  PackageCubit({required this.getPackageUseCase}) : super(PackageInitial());

  Future<void> getAllJobPackage(PkgType type) async {
    emit(PackageLoadingState());
    final failureOrSuccess = await getPackageUseCase.call(type);
    emit(_mapFailureOrFetchedToState(failureOrSuccess));
  }

  PackageState _mapFailureOrFetchedToState(Either<Failure, List<Package>> either) {
    return either.fold(
          (failure) => PackageErrorState(msg: _mapFailureToMessage(failure)),
          (packages) => PackageFetchedState(
          packages: packages
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
