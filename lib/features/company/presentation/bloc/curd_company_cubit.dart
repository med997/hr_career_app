import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/company/domain/usecases/update_company.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';

part 'curd_company_state.dart';

class CurdCompanyCubit extends Cubit<CurdCompanyState> {
  final UpdateCompany updateCompanyUserCase;

  CurdCompanyCubit({required this.updateCompanyUserCase}) : super(CurdCompanyInitial());

  Future<void> updateCompany(Map<String, dynamic>? value) async {
    if (value!['id'] == null) {
      emit(ErrorCurdCompanyState(message: "ID cannot be null"));
      return;
    }
    emit(LoadingCurdCompanyState());
    Company company = Company(
      id: value['id'],
      city: value['city'],
      email: value['email'],
      major: value['major'],
      phone: value['phone'],
      address: value['address'],
      nameAr: value['nameAr'],
      nameEn: value['nameEn'],
      website: value['website'],
      aboutUs: value['aboutUs'],
      companyLogo: value['companyLogo'],
      locations: value['locations'],
      createdAt: value['createdAt'],
      headOffice: value['headOffice'],
      imagesPath: value['imagesPath'],
      nationality: value['nationality'],
      videoPaths: value['videoPaths'],
      otherContact: value['otherContact'],
      documentPaths: value['documentPaths'],
    );
    final failureOrSuccess = await updateCompanyUserCase.call(company);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }

  CurdCompanyState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
          (failure) => ErrorCurdCompanyState(
        message: _mapFailureToMessage(failure),
      ),
          (_) => MessageCurdCompanyState(message: message),
    );
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
