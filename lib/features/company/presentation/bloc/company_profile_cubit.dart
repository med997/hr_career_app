import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/usecases/fetch_company.dart';

part 'company_profile_state.dart';

class CompanyProfileCubit extends Cubit<CompanyProfileState> {
  final FetchCompanyUserCase fetchCompanyUserCase;
  CompanyProfileCubit({required this.fetchCompanyUserCase}) : super(CompanyProfileInitial());

  Future<void> getCompanyByUuid(String uuid) async {
    emit( CompanyLoading());
    final failureOrSuccess = await fetchCompanyUserCase.getCompanyByUuid(uuid);
    emit(_mapFailureOrHomeToState(failureOrSuccess));
  }

  CompanyProfileState _mapFailureOrHomeToState(Either<Failure, Company> either) {
    return either.fold(
          (failure) => CompanyErrorState(msg: _mapFailureToMessage(failure)),
          (company) => CompanyFetchedState(
          company: company
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
